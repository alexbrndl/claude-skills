#!/usr/bin/env bash
# Validates all SKILL.md files in plugins/. Usage: scripts/validate-skills.sh [path]
set -u
ROOT="${1:-plugins}"
fail=0
while IFS= read -r f; do
  # frontmatter présent avec name: et description:
  head -1 "$f" | grep -q '^---$' || { echo "FAIL no frontmatter: $f"; fail=1; }
  awk '/^---$/{c++} c==1' "$f" | grep -q '^name:' || { echo "FAIL no name: $f"; fail=1; }
  awk '/^---$/{c++} c==1' "$f" | grep -q '^description:' || { echo "FAIL no description: $f"; fail=1; }
  # ≤ 500 lignes
  lines=$(wc -l < "$f")
  [ "$lines" -le 500 ] || { echo "FAIL $lines lines (>500): $f"; fail=1; }
  # pas d'auto-promo
  grep -q '?ref=' "$f" && { echo "FAIL ?ref= link: $f"; fail=1; }
done < <(find "$ROOT" -name SKILL.md)
# auto-promo dans les references aussi
if grep -rq '?ref=' "$ROOT" --include='*.md'; then
  grep -rl '?ref=' "$ROOT" --include='*.md' | while read -r f; do echo "FAIL ?ref= link: $f"; done
  fail=1
fi
[ "$fail" -eq 0 ] && echo "ALL OK ($(find "$ROOT" -name SKILL.md | wc -l | tr -d ' ') skills)"
exit $fail
