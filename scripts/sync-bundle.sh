#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
bundle="$root/plugins/palo-alto"
target="$bundle/skills"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for skill in "$bundle"/*/skills/*/; do
  cp -R "${skill%/}" "$tmp/"
done

if [ "${1:-}" = "--check" ]; then
  diff -r "$tmp" "$target"
  exit 0
fi

rm -rf "$target"
cp -R "$tmp" "$target"
