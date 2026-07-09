#!/usr/bin/env bash
set -euo pipefail

LESSONS_DIR="docs/assets/新概念-1/lessons"
TRIM_SECONDS="5"
APPLY="false"

usage() {
  cat <<'USAGE'
Usage:
  bash scripts/trim-new-concept-ads.sh [--apply] [--seconds N]

Trims the first N seconds from every .mp3 under:
  docs/assets/新概念-1/lessons

Default mode is a dry run. Pass --apply to overwrite the mp3 files in place.
Use --seconds to change the trim amount.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply)
      APPLY="true"
      shift
      ;;
    --seconds)
      if [[ $# -lt 2 ]]; then
        echo "--seconds requires a value" >&2
        usage >&2
        exit 2
      fi
      TRIM_SECONDS="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg is required but was not found in PATH." >&2
  exit 1
fi

if [[ ! -d "$LESSONS_DIR" ]]; then
  echo "Lessons directory not found: $LESSONS_DIR" >&2
  exit 1
fi

if ! [[ "$TRIM_SECONDS" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "--seconds must be a positive number" >&2
  exit 2
fi

count=0
while IFS= read -r -d '' mp3; do
  count=$((count + 1))

  if [[ "$APPLY" != "true" ]]; then
    printf '[dry-run] trim first %ss: %s\n' "$TRIM_SECONDS" "$mp3"
    continue
  fi

  dir="$(dirname "$mp3")"
  base="$(basename "$mp3")"
  tmp="$(mktemp "$dir/.${base}.trimmed.XXXXXX.mp3")"

  if ffmpeg -hide_banner -loglevel error -y \
    -ss "$TRIM_SECONDS" \
    -i "$mp3" \
    -map 0:a:0 \
    -c:a copy \
    "$tmp"; then
    mv "$tmp" "$mp3"
    printf '[trimmed] %s\n' "$mp3"
  else
    rm -f "$tmp"
    printf '[failed] %s\n' "$mp3" >&2
    exit 1
  fi
done < <(find "$LESSONS_DIR" -type f -name '*.mp3' -print0 | sort -z)

if [[ "$count" -eq 0 ]]; then
  echo "No mp3 files found under $LESSONS_DIR"
else
  echo "Found $count mp3 file(s)."
fi

if [[ "$APPLY" != "true" ]]; then
  echo "Dry run only. Re-run with --apply to modify files."
fi
