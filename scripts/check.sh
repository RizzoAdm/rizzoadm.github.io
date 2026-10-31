#!/usr/bin/env bash
# check.sh — pre-publish checklist. Run it before every commit/push.
#
# Usage (Terminal, inside the site folder: cd ~/Projects/mr.rizzo):
#   bash scripts/check.sh            full check, including a production build (slower)
#   bash scripts/check.sh --quick    skip the build
#
# Checks:
#   1. every page has both languages (index.md + index.pt-br.md, _index.md + _index.pt-br.md)
#   2. every page has a summary or description (SEO and cards)
#   3. no TODO left from the templates
#   4. drafts (draft: true) outside the example-gallery templates
#   5. every project / hobby / gallery has a feature.jpg cover
#   6. images: no metadata (EXIF/GPS/XMP/IPTC), longest side <= 2560 px, file size <= 2 MB
#   7. production build (hugo --gc --minify) without ERROR or WARN (the Blowfish version WARN is ignored)
#   8. git status: what will go into the commit
# Result: ERROR = fix before publishing; WARN = look at it, may be intentional.

set -uo pipefail
cd "$(dirname "$0")/.."

QUICK=0; [[ "${1:-}" == "--quick" ]] && QUICK=1
errors=0; warns=0
err()  { echo "  ERROR  $*"; errors=$((errors+1)); }
warn() { echo "  WARN   $*"; warns=$((warns+1)); }
ok()   { echo "  ok     $*"; }
fm()   { awk 'NR==1&&/^---/{f=1;next} f&&/^---/{exit} f' "$1"; }   # front matter of a file
is_template() { [[ "$1" == *example-gallery* ]]; }

mapfile -t PAGES < <(find content -type f \( -name 'index.md' -o -name '_index.md' -o -name 'index.pt-br.md' -o -name '_index.pt-br.md' \) | sort)

echo "1. Both languages"
n0=$errors
for f in "${PAGES[@]}"; do
  case "$f" in
    *.pt-br.md) other="${f%.pt-br.md}.md" ;;
    *)          other="${f%.md}.pt-br.md" ;;
  esac
  [[ -f "$other" ]] || err "$f has no pair: missing $other"
done
(( errors == n0 )) && ok "all ${#PAGES[@]} files have their pair"

echo "2. Summary / description"
n0=$errors
for f in "${PAGES[@]}"; do
  [[ "$f" == content/_index* || "$f" == content/thanks/* ]] && continue   # home uses the site description; thanks is noindex
  fm "$f" | grep -qE '^(summary|description):' || err "$f has no summary or description"
done
(( errors == n0 )) && ok "all pages have one"

echo "3. TODO left from the templates"
n0=$errors
while IFS= read -r line; do
  is_template "$line" && continue
  err "$line"
done < <(grep -rn --include='*.md' --include='*.yaml' 'TODO' content || true)
(( errors == n0 )) && ok "none"

echo "4. Drafts"
n0=$warns
for f in "${PAGES[@]}"; do
  is_template "$f" && continue
  fm "$f" | grep -qE '^draft: *true' && warn "$f is a draft (draft: true): it will NOT be published"
done
(( warns == n0 )) && ok "none outside the templates"

echo "5. Covers (feature.jpg)"
n0=$warns
while IFS= read -r d; do
  is_template "$d" && continue
  [[ -f "$d/index.md" || -f "$d/_index.md" ]] || continue
  [[ -f "$d/feature.jpg" ]] || warn "$d has no feature.jpg (card without image). Make one: bash scripts/new.sh cover $d"
done < <(find content/projects content/hobbies -mindepth 1 -type d ! -name gallery | sort)
(( warns == n0 )) && ok "all cards have a cover"

echo "6. Images (metadata, size)"
if ! command -v identify >/dev/null; then
  warn "ImageMagick not installed (sudo apt install imagemagick): images not checked"
else
  n0=$errors; w0=$warns; count=0
  while IFS= read -r img; do
    count=$((count+1))
    info=$(identify -format '%w %h %[profiles]' "$img[0]" 2>/dev/null)
    w=${info%% *}; rest=${info#* }; h=${rest%% *}; prof=${rest#* }
    [[ "$rest" == "$h" ]] && prof=""
    if echo "$prof" | grep -qiE 'exif|xmp|iptc|8bim'; then
      err "$img has metadata ($prof). Run it through scripts/prepare-images.sh"
    fi
    if [[ "$w" =~ ^[0-9]+$ && "$h" =~ ^[0-9]+$ ]] && (( w > 2560 || h > 2560 )); then
      warn "$img is ${w}x${h} (max 2560 on the longest side)"
    fi
    size=$(stat -c %s "$img")
    (( size > 2*1024*1024 )) && warn "$img is $((size/1024)) KB (over 2 MB)"
  done < <(find content assets/img -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort)
  (( errors == n0 && warns == w0 )) && ok "$count images, no metadata, sizes fine"
fi

echo "7. Production build"
if (( QUICK )); then
  echo "  skip   (--quick)"
elif ! command -v hugo >/dev/null; then
  err "hugo not found"
else
  out=$(hugo --gc --minify 2>&1); status=$?
  probs=$(echo "$out" | grep -E '^(ERROR|WARN)' | grep -viE 'blowfish|compatib|version' || true)
  if (( status != 0 )); then
    err "build failed:"; echo "$out" | grep -E 'ERROR|error' | head -20 | sed 's/^/         /'
  elif [[ -n "$probs" ]]; then
    warn "build has warnings:"; echo "$probs" | head -20 | sed 's/^/         /'
  else
    ok "build fine ($(echo "$out" | grep -oE 'Total in [0-9]+ ms'))"
  fi
fi

echo "8. Git: files that will go into the commit"
if git rev-parse --git-dir >/dev/null 2>&1; then
  st=$(git status --short)
  if [[ -z "$st" ]]; then echo "  nothing changed"; else echo "$st" | sed 's/^/         /'; fi
fi

echo
if (( errors )); then
  echo "RESULT: $errors error(s), $warns warning(s). Fix the errors before publishing."
  exit 1
elif (( warns )); then
  echo "RESULT: no errors, $warns warning(s). Check them; if they are intentional, you can publish."
else
  echo "RESULT: all good. Next: hugo server + phone check, then commit and push."
fi
