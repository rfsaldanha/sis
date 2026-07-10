#!/usr/bin/env bash
set -euo pipefail

rules_file="${1:-podcast/pronunciation_dictionary_siglas.json}"

: "${ELEVENLABS_API_KEY:?Set ELEVENLABS_API_KEY before running this script.}"

for cmd in curl jq; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$cmd" >&2
    exit 1
  fi
done

if [ ! -f "$rules_file" ]; then
  printf 'Rules file not found: %s\n' "$rules_file" >&2
  exit 1
fi

curl_config=$(mktemp "${TMPDIR:-/tmp}/elevenlabs-pronunciation-curl.XXXXXX")
chmod 600 "$curl_config"
{
  printf 'url = "https://api.elevenlabs.io/v1/pronunciation-dictionaries/add-from-rules"\n'
  printf 'header = "xi-api-key: %s"\n' "$ELEVENLABS_API_KEY"
  printf 'header = "Content-Type: application/json"\n'
} > "$curl_config"

response_file=$(mktemp "${TMPDIR:-/tmp}/elevenlabs-pronunciation-response.XXXXXX.json")
curl -sS -K "$curl_config" -d @"$rules_file" --output "$response_file"
rm -f "$curl_config"

if jq -e '.id and .version_id' "$response_file" >/dev/null 2>&1; then
  jq -r '"Created pronunciation dictionary: \(.name)\nELEVENLABS_PRONUNCIATION_DICTIONARY_ID=\(.id)\nELEVENLABS_PRONUNCIATION_DICTIONARY_VERSION_ID=\(.version_id)"' "$response_file"
else
  printf 'ElevenLabs response did not include dictionary id/version_id. Response body:\n' >&2
  sed -n '1,80p' "$response_file" >&2
  exit 1
fi
rm -f "$response_file"
