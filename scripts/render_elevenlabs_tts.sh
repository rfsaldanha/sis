#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  printf 'Usage: %s <chapter> [output-prefix]\n' "$0" >&2
  printf 'Example: %s eventos eventos_dialogo_elevenlabs\n' "$0" >&2
  exit 2
fi

chapter="$1"
output_prefix="${2:-${chapter}_dialogo_elevenlabs}"
input_tsv="podcast/${chapter}.tsv"
generated_tsv=""
if [ ! -f "$input_tsv" ] && [ -f "podcast/${chapter}_dialogo.tsv" ]; then
  input_tsv="podcast/${chapter}_dialogo.tsv"
fi
if [ ! -f "$input_tsv" ] && [ -f "podcast/${chapter}.md" ]; then
  generated_tsv=$(mktemp "${TMPDIR:-/tmp}/${chapter}-turns.XXXXXX")
  awk '/^\*\*(APRESENTADORA|ESTUDANTE):\*\*/ { speaker=$0; sub(/^\*\*/, "", speaker); sub(/:\*\*.*/, "", speaker); text=$0; sub(/^\*\*(APRESENTADORA|ESTUDANTE):\*\* /, "", text); print speaker "\t" text }' "podcast/${chapter}.md" > "$generated_tsv"
  input_tsv="$generated_tsv"
fi

chunks_dir="podcast/${output_prefix}_chunks"
batches_dir="$chunks_dir/batches"
transcripts_dir="$chunks_dir/transcripts"
concat_file="podcast/${output_prefix}_concat.txt"
transcript_file="podcast/${output_prefix}_transcript.json"
output_mp3="podcast/${output_prefix}.mp3"

dry_run="${ELEVENLABS_DRY_RUN:-false}"

if [ "$dry_run" != true ]; then
  : "${ELEVENLABS_API_KEY:?Set ELEVENLABS_API_KEY before running this script.}"
fi

host_voice_id="${ELEVENLABS_HOST_VOICE_ID:-RKj1DIXprh8zdvjllfhJ}"
student_voice_id="${ELEVENLABS_STUDENT_VOICE_ID:-ec54d9BmuMSN4IinPrjv}"
model="${ELEVENLABS_TTS_MODEL:-eleven_v3}"
output_format="${ELEVENLABS_OUTPUT_FORMAT:-mp3_44100_128}"
language_code="${ELEVENLABS_LANGUAGE_CODE:-pt}"
apply_text_normalization="${ELEVENLABS_APPLY_TEXT_NORMALIZATION:-auto}"
max_chars="${ELEVENLABS_DIALOGUE_MAX_CHARS:-1900}"
batch_pause_seconds="${ELEVENLABS_DIALOGUE_BATCH_PAUSE_SECONDS:-0.25}"
use_expressive_tags="${ELEVENLABS_DIALOGUE_EXPRESSIVE_TAGS:-true}"
seed="${ELEVENLABS_SEED:-}"
pronunciation_dictionary_id="${ELEVENLABS_PRONUNCIATION_DICTIONARY_ID:-}"
pronunciation_dictionary_version_id="${ELEVENLABS_PRONUNCIATION_DICTIONARY_VERSION_ID:-}"

for cmd in curl jq base64 ffmpeg ffprobe awk; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$cmd" >&2
    exit 1
  fi
done

have_ffmpeg=true

if [ ! -f "$input_tsv" ]; then
  printf 'Input not found. Expected podcast/%s.tsv, podcast/%s_dialogo.tsv, or podcast/%s.md\n' "$chapter" "$chapter" "$chapter" >&2
  exit 1
fi

case "$use_expressive_tags" in
  true|false) ;;
  *)
    printf 'ELEVENLABS_DIALOGUE_EXPRESSIVE_TAGS must be true or false.\n' >&2
    exit 1
    ;;
esac

if [ -n "$seed" ] && ! printf '%s\n' "$seed" | awk '/^[0-9]+$/ { ok=1 } END { exit ok ? 0 : 1 }'; then
  printf 'ELEVENLABS_SEED must be an integer between 0 and 4294967295.\n' >&2
  exit 1
fi

if { [ -n "$pronunciation_dictionary_id" ] && [ -z "$pronunciation_dictionary_version_id" ]; } || { [ -z "$pronunciation_dictionary_id" ] && [ -n "$pronunciation_dictionary_version_id" ]; }; then
  printf 'Set both ELEVENLABS_PRONUNCIATION_DICTIONARY_ID and ELEVENLABS_PRONUNCIATION_DICTIONARY_VERSION_ID, or neither.\n' >&2
  exit 1
fi

mkdir -p "$chunks_dir" "$batches_dir" "$transcripts_dir"

rm -f "$batches_dir"/[0-9][0-9][0-9].tsv "$transcripts_dir"/[0-9][0-9][0-9].json

awk -v out_dir="$batches_dir" -v max_chars="$max_chars" '
  BEGIN { batch = 1; chars = 0; rows = 0 }
  NF {
    text = $0
    sub(/^[^\t]*\t/, "", text)
    len = length(text)
    if (rows > 0 && chars + len > max_chars) {
      batch++
      chars = 0
      rows = 0
    }
    file = sprintf("%s/%03d.tsv", out_dir, batch)
    print $0 >> file
    chars += len
    rows++
  }
' "$input_tsv"

if ! test -f "$batches_dir/001.tsv"; then
  printf 'Input has no dialogue turns: %s\n' "$input_tsv" >&2
  exit 1
fi

seed_json="null"
if [ -n "$seed" ]; then
  seed_json="$seed"
fi

silence=""
silence_duration=0
if [ "$have_ffmpeg" = true ]; then
  silence="$chunks_dir/batch_pause.mp3"
  ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t "$batch_pause_seconds" -codec:a libmp3lame -q:a 2 "$silence" >/dev/null 2>&1
  silence_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$silence")
elif [ "$batch_pause_seconds" != "0" ] && [ "$batch_pause_seconds" != "0.0" ]; then
  printf 'ffmpeg/ffprobe not found; concatenating MP3 chunks without synthetic pauses.
' >&2
fi

printf 'Rendering %s with ElevenLabs Text to Dialogue (%s), max %s chars per request\n' "$chapter" "$model" "$max_chars"

time_offset=0
for batch_tsv in "$batches_dir"/[0-9][0-9][0-9].tsv; do
  batch_id=$(basename "$batch_tsv" .tsv)
  chunk="$chunks_dir/${batch_id}.mp3"
  response_json="$chunks_dir/${batch_id}.response.json"
  transcript_part="$transcripts_dir/${batch_id}.json"

  if [ -s "$chunk" ] && [ -s "$response_json" ] && { [ "$have_ffmpeg" = false ] || ffprobe -v error "$chunk" >/dev/null 2>&1; }; then
    printf 'Skipping %s batch %s: existing valid audio\n' "$chapter" "$batch_id"
  else
    turns=$(wc -l < "$batch_tsv" | awk '{ print $1 }')
    chars=$(awk -F '\t' '{ total += length($2) } END { print total + 0 }' "$batch_tsv")
    printf 'Rendering %s batch %s (%s turns, %s chars)\n' "$chapter" "$batch_id" "$turns" "$chars"

    payload=$(jq -Rn \
      --arg model "$model" \
      --arg language_code "$language_code" \
      --arg apply_text_normalization "$apply_text_normalization" \
      --arg host_voice_id "$host_voice_id" \
      --arg student_voice_id "$student_voice_id" \
      --arg pronunciation_dictionary_id "$pronunciation_dictionary_id" \
      --arg pronunciation_dictionary_version_id "$pronunciation_dictionary_version_id" \
      --argjson seed "$seed_json" \
      --argjson use_tags "$use_expressive_tags" '
        def tag($speaker; $text):
          if ($use_tags | not) then $text
          elif ($text | startswith("[")) then $text
          elif $speaker == "APRESENTADORA" then
            ((if ($text | test("\\?$")) then "[curious] "
              elif ($text | test("^(Exatamente|Perfeito|Sim|Isso)")) then "[warmly] "
              else "[thoughtful] "
              end) + $text)
          else
            ((if ($text | test("\\?$")) then "[curious] "
              elif ($text | test("^(Nossa|Quarenta|Boa|Bonita)")) then "[surprised] "
              else "[engaged] "
              end) + $text)
          end;

        [inputs
          | split("\t")
          | select(length >= 2)
          | {speaker: .[0], text: (.[1:] | join("\t"))}
        ] as $rows
        | {
            inputs: ($rows | map({
              text: tag(.speaker; .text),
              voice_id: (if .speaker == "APRESENTADORA" then $host_voice_id else $student_voice_id end)
            })),
            model_id: $model,
            language_code: $language_code,
            apply_text_normalization: $apply_text_normalization
          }
          + (if $seed == null then {} else {seed: $seed} end)
          + (if ($pronunciation_dictionary_id != "" and $pronunciation_dictionary_version_id != "") then {
              pronunciation_dictionary_locators: [{
                pronunciation_dictionary_id: $pronunciation_dictionary_id,
                version_id: $pronunciation_dictionary_version_id
              }]
            } else {} end)
      ' "$batch_tsv")

    if [ "$dry_run" = true ]; then
      printf '%s
' "$payload" > "$chunks_dir/${batch_id}.payload.json"
      continue
    fi

    curl_config=$(mktemp "${TMPDIR:-/tmp}/elevenlabs-dialogue-curl.XXXXXX")
    chmod 600 "$curl_config"
    {
      printf 'url = "https://api.elevenlabs.io/v1/text-to-dialogue/with-timestamps?output_format=%s"\n' "$output_format"
      printf 'header = "xi-api-key: %s"\n' "$ELEVENLABS_API_KEY"
      printf 'header = "Content-Type: application/json"\n'
    } > "$curl_config"

    curl -sS -K "$curl_config" -d "$payload" --output "$response_json"
    rm -f "$curl_config"

    if jq -e '.audio_base64' "$response_json" >/dev/null 2>&1; then
      jq -r '.audio_base64' "$response_json" | base64 -d > "$chunk"
    else
      printf 'ElevenLabs response did not include audio for batch %s. Response body:\n' "$batch_id" >&2
      sed -n '1,40p' "$response_json" >&2
      exit 1
    fi

    if ! ffprobe -v error "$chunk" >/dev/null 2>&1; then
      printf 'ElevenLabs response was not valid audio for batch %s. Response body:\n' "$batch_id" >&2
      sed -n '1,40p' "$response_json" >&2
      exit 1
    fi
  fi

  jq -Rn \
    --argjson offset "$time_offset" \
    --slurpfile response "$response_json" '
      [inputs
        | split("\t")
        | select(length >= 2)
        | {speaker: .[0], text: (.[1:] | join("\t") | gsub("\\[[^]]+\\]\\s*"; ""))}
      ] as $rows
      | ($response[0].voice_segments // []) as $segments
      | [
          range(0; $rows | length) as $idx
          | ($segments | map(select(.dialogue_input_index == $idx))) as $turn_segments
          | {
              start: (((if ($turn_segments | length) > 0 then ($turn_segments | map(.start_time_seconds) | min) else 0 end) + $offset) * 1000 | round / 1000),
              end: (((if ($turn_segments | length) > 0 then ($turn_segments | map(.end_time_seconds) | max) else 0 end) + $offset) * 1000 | round / 1000),
              speaker: $rows[$idx].speaker,
              text: $rows[$idx].text
            }
        ]
    ' "$batch_tsv" > "$transcript_part"

  if [ "$have_ffmpeg" = true ]; then
    duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$chunk")
  else
    duration=$(jq '[.voice_segments[]?.end_time_seconds] | max // 0' "$response_json")
  fi
  time_offset=$(awk -v a="$time_offset" -v b="$duration" -v c="$silence_duration" 'BEGIN { printf "%.3f", a + b + c }')
done

: > "$concat_file"
for f in "$chunks_dir"/[0-9][0-9][0-9].mp3; do
  printf "file '%s'\n" "$(pwd)/$f" >> "$concat_file"
  printf "file '%s'\n" "$(pwd)/$silence" >> "$concat_file"
done

ffmpeg -y -f concat -safe 0 -i "$concat_file" -codec:a libmp3lame -b:a 128k -write_xing 1 "$output_mp3"

jq -s 'add' "$transcripts_dir"/[0-9][0-9][0-9].json > "$transcript_file"

printf '\nCreated:\n'
printf '  %s\n' "$output_mp3"
printf '  %s\n' "$transcript_file"
