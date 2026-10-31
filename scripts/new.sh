#!/usr/bin/env bash
# new.sh — create new site content in one command (EN + PT pages, images, cover).
#
# Usage (run in the Terminal, inside the site folder: cd ~/Projects/mr.rizzo):
#   bash scripts/new.sh project <slug> [image folder]
#   bash scripts/new.sh gallery <section> <slug> <image folder>     section = photography | 3d-for-fun | cooking
#   bash scripts/new.sh hobby   <slug> [image folder]
#   bash scripts/new.sh images  <page folder> <image folder>         add images to an existing page
#   bash scripts/new.sh cover   <page folder> [image]                 (re)make feature.jpg (3:2, 1200x800)
#
# Examples:
#   bash scripts/new.sh project 3d-robot ~/Pictures/site-originais/projects/3d-robot
#   bash scripts/new.sh gallery photography winter-2026 ~/Pictures/site-originais/photography/winter-2026
#   bash scripts/new.sh images content/hobbies/photography/moon ~/Pictures/novas-luas
#   bash scripts/new.sh cover content/projects/3d-robot content/projects/3d-robot/gallery/03.jpg
#
# What it does:
#   - creates the page bundle from archetypes/ (index.md + index.pt-br.md, front matter, TODO placeholders)
#   - sets "weight" to the last card + 10, so the new item goes to the end of the list
#   - copies the images through scripts/prepare-images.sh (renames 01.jpg..., strips ALL metadata, resizes)
#   - makes feature.jpg from the first image (center crop) if there is no cover yet
# It never changes the original images and never overwrites an existing page.
# Next step is always: edit the two index files, then run  bash scripts/check.sh

set -euo pipefail
cd "$(dirname "$0")/.."

die()  { echo "ERROR: $*" >&2; exit 1; }
info() { echo "  $*"; }

usage() { sed -n '4,10p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }

check_slug() {
  [[ "$1" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || die "invalid name '$1'. Use lowercase English, digits and hyphens (ex.: winter-2026). No spaces, accents or place names near home."
}

need_tools() {
  command -v hugo >/dev/null    || die "hugo not found."
  command -v convert >/dev/null || die "ImageMagick not installed. Run: sudo apt install imagemagick"
}

# next weight = highest weight among sibling pages (EN files, ignoring 999 templates) + 10
next_weight() {
  local parent="$1" max=0 w
  while read -r w; do
    [[ "$w" =~ ^[0-9]+$ ]] || continue
    (( w >= 999 )) && continue
    (( w > max )) && max=$w
  done < <(find "$parent" -mindepth 2 -maxdepth 2 \( -name index.md -o -name _index.md \) \
             -exec awk 'NR==1&&/^---/{f=1;next} f&&/^---/{exit} f&&/^weight:/{print $2}' {} \;)
  echo $(( max + 10 ))
}

set_weight() {  # $1 = bundle dir, $2 = weight
  sed -i "0,/^weight: .*/s//weight: $2/" "$1/index.md" "$1/index.pt-br.md"
}

next_number() { # next free image number in a gallery folder
  local dir="$1" max=0 n f
  [[ -d "$dir" ]] || { echo 1; return; }
  for f in "$dir"/*.jpg; do
    [[ -e "$f" ]] || continue
    n=$(basename "$f" .jpg); [[ "$n" =~ ^[0-9]+$ ]] || continue; n=$((10#$n))
    (( n > max )) && max=$n
  done
  echo $(( max + 1 ))
}

make_cover() {  # $1 = bundle dir, $2 = source image (optional)
  local dir="$1" src="${2:-}"
  if [[ -z "$src" ]]; then
    src=$(find "$dir/gallery" -maxdepth 1 -name '*.jpg' 2>/dev/null | sort -V | head -1 || true)
  fi
  [[ -n "$src" && -f "$src" ]] || { info "no image for the cover yet: add $dir/feature.jpg later (3:2, 1200x800)"; return; }
  convert "$src" -auto-orient -colorspace sRGB -resize 1200x800^ -gravity center -extent 1200x800 \
    -strip -quality 88 "$dir/feature.jpg"
  info "cover: $dir/feature.jpg (from $(basename "$src"), center crop)"
}

add_images() {  # $1 = bundle dir, $2 = image folder
  local dir="$1" src="$2"
  [[ -d "$src" ]] || die "image folder not found: $src"
  local start; start=$(next_number "$dir/gallery")
  bash scripts/prepare-images.sh "$src" "$dir/gallery" "$start" | sed 's/^/  /'
}

create() {  # $1 = content path (relative to content/), $2 = kind
  local path="$1" kind="$2" dir="content/$1"
  [[ -e "$dir" ]] && die "$dir already exists. To change it, edit the files; to add images use: bash scripts/new.sh images $dir <folder>"
  hugo new content "$path" --kind "$kind" >/dev/null
  set_weight "$dir" "$(next_weight "$(dirname "$dir")")"
  info "created $dir/index.md and index.pt-br.md (weight $(awk '/^weight:/{print $2; exit}' "$dir/index.md"))"
}

finish() {  # $1 = bundle dir
  local dir="$1"
  echo
  echo "Next steps:"
  echo "  1. Edit in VS Code:  code $dir/index.md $dir/index.pt-br.md"
  echo "     Replace every TODO. 'weight' controls the order of the cards (lower = first)."
  [[ -f "$dir/photos.yaml" ]] && echo "     Optional highlights: $dir/photos.yaml"
  echo "  2. Preview:  hugo server   ->  http://localhost:1313"
  echo "  3. Check:    bash scripts/check.sh"
  echo "  4. Publish:  git add $dir && git commit -m \"Add ...\" && git push"
}

[[ $# -ge 1 ]] || usage
cmd="$1"; shift

case "$cmd" in
  project)
    [[ $# -ge 1 ]] || usage; need_tools; check_slug "$1"
    dir="content/projects/$1"
    echo "New project: $dir"
    create "projects/$1" projects
    [[ $# -ge 2 ]] && add_images "$dir" "$2"
    make_cover "$dir"
    finish "$dir" ;;

  gallery)
    [[ $# -ge 3 ]] || usage; need_tools
    section="$1"; check_slug "$2"
    [[ -f "content/hobbies/$section/_index.md" ]] || die "section '$section' not found. Options: $(cd content/hobbies && for d in */; do [[ -f "$d/_index.md" ]] && printf '%s ' "${d%/}"; done)"
    dir="content/hobbies/$section/$2"
    echo "New gallery: $dir"
    create "hobbies/$section/$2" gallery
    add_images "$dir" "$3"
    make_cover "$dir"
    grep -q 'render: never' "content/hobbies/$section/_index.md" && \
      echo "  NOTE: the '$section' section is hidden (build block in its _index.md). Remove that block to publish it."
    finish "$dir" ;;

  hobby)
    [[ $# -ge 1 ]] || usage; need_tools; check_slug "$1"
    dir="content/hobbies/$1"
    echo "New hobby page: $dir"
    create "hobbies/$1" hobby
    [[ $# -ge 2 ]] && add_images "$dir" "$2"
    make_cover "$dir"
    finish "$dir" ;;

  images)
    [[ $# -ge 2 ]] || usage; need_tools
    dir="${1%/}"; [[ -f "$dir/index.md" ]] || die "$dir is not a page folder (no index.md)."
    echo "Adding images to $dir/gallery"
    add_images "$dir" "$2"
    [[ -f "$dir/feature.jpg" ]] || make_cover "$dir"
    echo
    echo "Next: place the new photos in the text if needed (rz-photos / rz-gallery), adjust photos.yaml, then: bash scripts/check.sh" ;;

  cover)
    [[ $# -ge 1 ]] || usage; need_tools
    dir="${1%/}"; [[ -f "$dir/index.md" || -f "$dir/_index.md" ]] || die "$dir is not a page folder."
    make_cover "$dir" "${2:-}" ;;

  *) usage ;;
esac
