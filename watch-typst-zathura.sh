#!/usr/bin/env bash
set -euo pipefail

input="${1:-AG1.typ}"
output="${2:-${input%.typ}.pdf}"

out_dir="$(dirname -- "$output")"
out_base="$(basename -- "$output")"
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/typst-zathura.XXXXXX")"
tmp_pdf="$tmp_dir/$out_base"

watch_pid=""
cleanup() {
  if [ -n "$watch_pid" ]; then
    kill "$watch_pid" 2>/dev/null || true
  fi
  rm -rf -- "$tmp_dir"
}
trap cleanup EXIT INT TERM

publish_pdf() {
  local staged
  staged="$out_dir/.$out_base.tmp.$$"
  cp -- "$tmp_pdf" "$staged"
  mv -f -- "$staged" "$output"
}

mkdir -p -- "$out_dir"

typst compile --creation-timestamp 0 "$input" "$tmp_pdf"
publish_pdf

zathura "$output" >/dev/null 2>&1 &

typst watch --creation-timestamp 0 "$input" "$tmp_pdf" &
watch_pid="$!"

last_seen=""
last_published=""
stable_count=0

while kill -0 "$watch_pid" 2>/dev/null; do
  if [ -s "$tmp_pdf" ]; then
    current="$(stat -c '%Y:%s' -- "$tmp_pdf")"

    if [ "$current" = "$last_seen" ]; then
      stable_count=$((stable_count + 1))
    else
      last_seen="$current"
      stable_count=0
    fi

    if [ "$stable_count" -ge 2 ] && [ "$current" != "$last_published" ]; then
      publish_pdf
      last_published="$current"
    fi
  fi

  sleep 0.25
done

wait "$watch_pid"
