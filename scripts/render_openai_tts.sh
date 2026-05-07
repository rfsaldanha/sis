#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  printf 'Usage: %s <chapter> [output-prefix]\n' "$0" >&2
  printf 'Example: %s eventos eventos_dialogo_openai\n' "$0" >&2
  exit 2
fi

chapter="$1"
output_prefix="${2:-${chapter}_dialogo_openai}"
input_tsv="podcast/${chapter}_dialogo.tsv"
chunks_dir="podcast/${output_prefix}_chunks"
concat_file="podcast/${output_prefix}_concat.txt"
transcript_file="podcast/${output_prefix}_transcript.json"
output_mp3="podcast/${output_prefix}.mp3"

: "${OPENAI_API_KEY:?Set OPENAI_API_KEY before running this script.}"

for cmd in curl jq ffmpeg ffprobe; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$cmd" >&2
    exit 1
  fi
done

if [ ! -f "$input_tsv" ]; then
  printf 'Input not found: %s\n' "$input_tsv" >&2
  exit 1
fi

mkdir -p "$chunks_dir"

host_voice="${OPENAI_TTS_HOST_VOICE:-marin}"
student_voice="${OPENAI_TTS_STUDENT_VOICE:-cedar}"
model="${OPENAI_TTS_MODEL:-gpt-4o-mini-tts}"
host_instructions="${OPENAI_TTS_HOST_INSTRUCTIONS:-Fale em portugues brasileiro, em tom academico, natural e acolhedor. Ritmo calmo, como uma professora explicando para estudantes.}"
student_instructions="${OPENAI_TTS_STUDENT_INSTRUCTIONS:-Fale em portugues brasileiro, em tom curioso e relaxado, como estudante fazendo perguntas. Ritmo natural e claro.}"

i=0
while IFS=$'\t' read -r speaker text; do
  i=$((i + 1))
  chunk=$(printf '%s/%03d.mp3' "$chunks_dir" "$i")

  if [ "$speaker" = "APRESENTADORA" ]; then
    voice="$host_voice"
    instructions="$host_instructions"
  else
    voice="$student_voice"
    instructions="$student_instructions"
  fi

  if [ -s "$chunk" ] && ffprobe -v error "$chunk" >/dev/null 2>&1; then
    printf 'Skipping %s turn %03d (%s): existing valid audio\n' "$chapter" "$i" "$speaker"
    continue
  fi

  printf 'Rendering %s turn %03d (%s, voice=%s)\n' "$chapter" "$i" "$speaker" "$voice"

  payload=$(jq -n \
    --arg model "$model" \
    --arg voice "$voice" \
    --arg input "$text" \
    --arg instructions "$instructions" \
    '{model:$model, voice:$voice, input:$input, instructions:$instructions, response_format:"mp3"}')

  curl_config=$(mktemp "${TMPDIR:-/tmp}/openai-tts-curl.XXXXXX")
  chmod 600 "$curl_config"
  {
    printf 'url = "https://api.openai.com/v1/audio/speech"\n'
    printf 'header = "Authorization: Bearer %s"\n' "$OPENAI_API_KEY"
    printf 'header = "Content-Type: application/json"\n'
  } > "$curl_config"

  curl -sS -K "$curl_config" -d "$payload" --output "$chunk"
  rm -f "$curl_config"

  if ! ffprobe -v error "$chunk" >/dev/null; then
    printf 'OpenAI TTS response was not valid audio for turn %03d. Check API key, model, and quota.\n' "$i" >&2
    exit 1
  fi
done < "$input_tsv"

silence="$chunks_dir/silence.mp3"
ffmpeg -y -f lavfi -i anullsrc=r=24000:cl=mono -t 0.35 -codec:a libmp3lame -q:a 2 "$silence" >/dev/null 2>&1

: > "$concat_file"
for f in "$chunks_dir"/[0-9][0-9][0-9].mp3; do
  printf "file '%s'\n" "$(pwd)/$f" >> "$concat_file"
  printf "file '%s'\n" "$(pwd)/$silence" >> "$concat_file"
done

ffmpeg -y -f concat -safe 0 -i "$concat_file" -codec:a libmp3lame -q:a 2 "$output_mp3"

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
