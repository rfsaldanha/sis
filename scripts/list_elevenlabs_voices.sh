#!/usr/bin/env bash
set -euo pipefail

: "${ELEVENLABS_API_KEY:?Set ELEVENLABS_API_KEY before running this script.}"

for cmd in curl jq; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$cmd" >&2
    exit 1
  fi
done

curl_config=$(mktemp "${TMPDIR:-/tmp}/elevenlabs-voices-curl.XXXXXX")
chmod 600 "$curl_config"
{
  printf 'url = "https://api.elevenlabs.io/v2/voices?page_size=100&include_total_count=true"\n'
  printf 'header = "xi-api-key: %s"\n' "$ELEVENLABS_API_KEY"
} > "$curl_config"

body=$(mktemp "${TMPDIR:-/tmp}/elevenlabs-voices.XXXXXX.json")
curl -sS -K "$curl_config" --output "$body"
rm -f "$curl_config"

jq -r '
  if .detail then
    .detail
  else
    .voices[]
    | [
        .name,
        .voice_id,
        (.labels.gender // "-"),
        (.labels.accent // "-"),
        (.labels.description // .description // "-")
      ]
    | @tsv
  end
' "$body"
rm -f "$body"
