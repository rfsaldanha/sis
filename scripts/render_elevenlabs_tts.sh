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
concat_file="podcast/${output_prefix}_concat.txt"
transcript_file="podcast/${output_prefix}_transcript.json"
output_mp3="podcast/${output_prefix}.mp3"

: "${ELEVENLABS_API_KEY:?Set ELEVENLABS_API_KEY before running this script.}"
host_voice_id="RKj1DIXprh8zdvjllfhJ"
student_voice_id="ec54d9BmuMSN4IinPrjv"

for cmd in curl jq ffmpeg ffprobe; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$cmd" >&2
    exit 1
  fi
done

if [ ! -f "$input_tsv" ]; then
  printf 'Input not found. Expected podcast/%s.tsv, podcast/%s_dialogo.tsv, or podcast/%s.md\n' "$chapter" "$chapter" "$chapter" >&2
  exit 1
fi

mkdir -p "$chunks_dir"

model="${ELEVENLABS_TTS_MODEL:-eleven_multilingual_v2}"
output_format="${ELEVENLABS_OUTPUT_FORMAT:-mp3_44100_128}"
stability="${ELEVENLABS_STABILITY:-0.55}"
similarity_boost="${ELEVENLABS_SIMILARITY_BOOST:-0.75}"
style="${ELEVENLABS_STYLE:-0.20}"
speaker_boost="${ELEVENLABS_USE_SPEAKER_BOOST:-true}"

i=0
while IFS=$'\t' read -r speaker text; do
  i=$((i + 1))
  chunk=$(printf '%s/%03d.mp3' "$chunks_dir" "$i")

  if [ "$speaker" = "APRESENTADORA" ]; then
    voice_id="$host_voice_id"
  else
    voice_id="$student_voice_id"
  fi

  if [ -s "$chunk" ] && ffprobe -v error "$chunk" >/dev/null 2>&1; then
    printf 'Skipping %s turn %03d (%s): existing valid audio\n' "$chapter" "$i" "$speaker"
    continue
  fi

  printf 'Rendering %s turn %03d (%s, voice_id=%s)\n' "$chapter" "$i" "$speaker" "$voice_id"

  payload=$(jq -n \
    --arg text "$text" \
    --arg model "$model" \
    --argjson stability "$stability" \
    --argjson similarity_boost "$similarity_boost" \
    --argjson style "$style" \
    --argjson use_speaker_boost "$speaker_boost" \
    '{
      text: $text,
      model_id: $model,
      language_code: "pt",
      voice_settings: {
        stability: $stability,
        similarity_boost: $similarity_boost,
        style: $style,
        use_speaker_boost: $use_speaker_boost
      }
    }')

  curl_config=$(mktemp "${TMPDIR:-/tmp}/elevenlabs-tts-curl.XXXXXX")
  chmod 600 "$curl_config"
  {
    printf 'url = "https://api.elevenlabs.io/v1/text-to-speech/%s?output_format=%s"\n' "$voice_id" "$output_format"
    printf 'header = "xi-api-key: %s"\n' "$ELEVENLABS_API_KEY"
    printf 'header = "Content-Type: application/json"\n'
  } > "$curl_config"

  curl -sS -K "$curl_config" -d "$payload" --output "$chunk"
  rm -f "$curl_config"

  if ! ffprobe -v error "$chunk" >/dev/null 2>&1; then
    printf 'ElevenLabs response was not valid audio for turn %03d. Response body:\n' "$i" >&2
    sed -n '1,30p' "$chunk" >&2
    exit 1
  fi
done < "$input_tsv"

silence="$chunks_dir/silence.mp3"
ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t 0.35 -codec:a libmp3lame -q:a 2 "$silence" >/dev/null 2>&1

: > "$concat_file"
for f in "$chunks_dir"/[0-9][0-9][0-9].mp3; do
  printf "file '%s'\n" "$(pwd)/$f" >> "$concat_file"
  printf "file '%s'\n" "$(pwd)/$silence" >> "$concat_file"
done

ffmpeg -y -f concat -safe 0 -i "$concat_file" -codec:a libmp3lame -b:a 128k -write_xing 1 "$output_mp3"

time=0
silence_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$silence")
printf '[\n' > "$transcript_file"
i=0
while IFS=$'\t' read -r speaker text; do
  i=$((i + 1))
  chunk=$(printf '%s/%03d.mp3' "$chunks_dir" "$i")
  duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$chunk")
  end=$(awk -v a="$time" -v b="$duration" 'BEGIN { printf "%.3f", a + b }')
  [ "$i" -gt 1 ] && printf ',\n' >> "$transcript_file"
  jq -n --arg speaker "$speaker" --arg text "$text" --argjson start "$time" --argjson end "$end" \
    '{start:$start,end:$end,speaker:$speaker,text:$text}' >> "$transcript_file"
  time=$(awk -v a="$end" -v b="$silence_duration" 'BEGIN { printf "%.3f", a + b }')
done < "$input_tsv"
printf '\n]\n' >> "$transcript_file"

printf '\nCreated:\n'
printf '  %s\n' "$output_mp3"
printf '  %s\n' "$transcript_file"
