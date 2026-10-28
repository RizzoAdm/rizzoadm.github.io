#!/usr/bin/env bash
# prepare-images.sh — get renders/photos ready for the website.
#
# What it does, for every image in the input folder (sorted by file name):
#   1. renames in sequence: 01.jpg, 02.jpg, 03.jpg ...
#   2. removes ALL metadata (EXIF, GPS, camera, Blender file path, etc.)
#   3. converts to sRGB JPEG, quality 88, longest side max 2560 px
# The original files are NEVER changed. Results go to a separate folder.
#
# Usage:
#   bash scripts/prepare-images.sh <input folder> <output folder> [start number]
# Example:
#   bash scripts/prepare-images.sh ~/Pictures/archviz content/projects/3d-archviz/gallery
#
# Requires ImageMagick:  sudo apt install imagemagick

set -euo pipefail

IN="${1:-}"; OUT="${2:-}"; START="${3:-1}"
MAX=2560        # longest side in pixels
QUALITY=88      # JPEG quality (0-100)

if [[ -z "$IN" || -z "$OUT" ]]; then
  echo "Usage: bash scripts/prepare-images.sh <input folder> <output folder> [start number]"; exit 1
fi
if [[ ! -d "$IN" ]]; then echo "Input folder not found: $IN"; exit 1; fi
command -v convert >/dev/null || { echo "ImageMagick not installed. Run: sudo apt install imagemagick"; exit 1; }

mkdir -p "$OUT"

mapfile -t FILES < <(find "$IN" -maxdepth 1 -type f \
  \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.tif' -o -iname '*.tiff' -o -iname '*.webp' \) \
  | sort -V)

if [[ ${#FILES[@]} -eq 0 ]]; then echo "No images found in $IN"; exit 1; fi

n=$START
for f in "${FILES[@]}"; do
  name=$(printf "%02d.jpg" "$n")
  if [[ -e "$OUT/$name" ]]; then
    echo "SKIP  $(basename "$f") -> $name already exists in $OUT"
  else
    convert "$f" -auto-orient -colorspace sRGB \
      -background black -alpha remove -alpha off \
      -resize "${MAX}x${MAX}>" -strip \
      -sampling-factor 4:2:0 -interlace JPEG -quality "$QUALITY" \
      "$OUT/$name"
    size=$(du -h "$OUT/$name" | cut -f1)
    echo "OK    $(basename "$f") -> $name ($size)"
  fi
  n=$((n + 1))
done

echo
echo "Done: ${#FILES[@]} file(s) processed into $OUT"
