#!/usr/bin/env bash
# Validates every SKILL.md and command under plugins/. Usage: scripts/validate-skills.sh [path]
set -u
ROOT="${1:-plugins}"
fail=0

frontmatter() { awk '/^---$/{c++; next} c==1' "$1"; }

# ---------- per-file checks ----------
while IFS= read -r f; do
  head -1 "$f" | grep -q '^---$' || { echo "FAIL no frontmatter: $f"; fail=1; }
  fm=$(frontmatter "$f")

  grep -q '^name:' <<<"$fm" || { echo "FAIL no name: $f"; fail=1; }
  grep -q '^description:' <<<"$fm" || { echo "FAIL no description: $f"; fail=1; }

  # directory name must match the name field, otherwise /invocation breaks
  dir=$(basename "$(dirname "$f")")
  nm=$(grep '^name:' <<<"$fm" | head -1 | sed 's/^name:[[:space:]]*//; s/["'\'']//g')
  [ -z "$nm" ] || [ "$nm" = "$dir" ] || { echo "FAIL name '$nm' != directory '$dir': $f"; fail=1; }

  # a description shorter than 80 chars cannot carry a trigger and a boundary
  desc=$(grep '^description:' <<<"$fm" | head -1 | sed 's/^description:[[:space:]]*//')
  [ "${#desc}" -ge 80 ] || { echo "WARN description under 80 chars, weak trigger: $f"; }

  # negative pointer: the description should say what it is NOT for
  grep -qiE 'not for|instead use|use .* instead' <<<"$desc" \
    || echo "WARN no negative pointer in description: $f"

  lines=$(wc -l < "$f")
  [ "$lines" -le 500 ] || { echo "FAIL $lines lines (>500): $f"; fail=1; }

  grep -q '?ref=' "$f" && { echo "FAIL ?ref= link: $f"; fail=1; }
done < <(find "$ROOT" -name SKILL.md)

# ---------- commands ----------
while IFS= read -r f; do
  head -1 "$f" | grep -q '^---$' || { echo "FAIL command without frontmatter: $f"; fail=1; }
  grep -q '^disable-model-invocation:[[:space:]]*true' <<<"$(frontmatter "$f")" \
    || { echo "FAIL command must set disable-model-invocation: true: $f"; fail=1; }
done < <(find "$ROOT" -path '*/commands/*.md' 2>/dev/null)

# ---------- collisions between descriptions ----------
# two skills whose descriptions share 4+ significant words are candidates for the
# same routing moment. Not fatal, but it is the thing that degrades selection.
python3 - "$ROOT" <<'PY' || true
import re, sys, pathlib, itertools
stop = set("""the a an and or of to for when use using with this that in on at is are be
before after not do does your you it its as from into than then only every each
skill skills claude code user users also whenever whether while what which where
already about asks says said something anything nothing else same other another
choosing choose picking pick making make writing write written wrote change
changes changed task tasks work works working thing things exists exist existing
looks look looking feels feel needs need want wants asked instead rather
several multiple single first second third often usually always never""".split())
def words(p):
    t = p.read_text(encoding='utf-8', errors='replace')
    m = re.match(r'^---\s*\n(.*?)\n---', t, re.S)
    b = m.group(1) if m else ''
    d = re.search(r'^description:\s*(.+)$', b, re.M)
    d = d.group(1).lower() if d else ''
    # cut at the negative pointer: it names the neighbouring skill on purpose,
    # so counting its words would flag every correctly written pair.
    d = re.split(r'\bnot for\b|\binstead use\b|\buse .{0,40}? instead\b', d)[0]
    return set(w for w in re.findall(r'[a-z]{4,}', d) if w not in stop)
skills = {p.parent.name: words(p) for p in pathlib.Path(sys.argv[1]).rglob('SKILL.md')}
for (a, wa), (b, wb) in itertools.combinations(sorted(skills.items()), 2):
    shared = wa & wb
    if len(shared) >= 4:
        print(f"WARN overlapping descriptions: {a} / {b} -> {', '.join(sorted(shared))}")
PY

# ---------- self promotion in references ----------
if grep -rq '?ref=' "$ROOT" --include='*.md'; then
  grep -rl '?ref=' "$ROOT" --include='*.md' | while read -r f; do echo "FAIL ?ref= link: $f"; done
  fail=1
fi

n=$(find "$ROOT" -name SKILL.md | wc -l | tr -d ' ')
c=$(find "$ROOT" -path '*/commands/*.md' 2>/dev/null | wc -l | tr -d ' ')
auto=$(grep -L 'disable-model-invocation:[[:space:]]*true' $(find "$ROOT" -name SKILL.md) 2>/dev/null | wc -l | tr -d ' ')
echo "---"
echo "$n skills, $c commands, $auto skills with automatic invocation"
[ "$fail" -eq 0 ] && echo "ALL OK"
exit $fail
