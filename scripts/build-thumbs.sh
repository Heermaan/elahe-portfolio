#!/usr/bin/env bash
# Generates grid thumbnails for every image under work/ and poster images for
# every video in _data/videos.yml. Output goes to assets/thumbs/ and
# assets/video-thumbs/ (both git-ignored; generated on every deploy).
# Full-size originals are untouched: the lightbox always opens the original.
set -euo pipefail
cd "$(dirname "$0")/.."
W=800   # thumbnail width in px (grid tiles render at ~430px, so this covers 2x screens)
Q=82

have() { command -v "$1" >/dev/null 2>&1; }
resize() { # in out width
  if have magick; then magick "$1" -auto-orient -strip -resize "${3}x>" -quality $Q -interlace Plane "$2"
  elif have convert; then convert "$1" -auto-orient -strip -resize "${3}x>" -quality $Q -interlace Plane "$2"
  else sips -Z "$3" -s format jpeg -s formatOptions $Q "$1" --out "$2" >/dev/null; fi
}
towebp() { # in out
  if have cwebp; then cwebp -quiet -q $Q "$1" -o "$2"
  elif have magick; then magick "$1" -quality $Q "$2"
  elif have convert; then convert "$1" -quality $Q "$2"; fi
}

n=0
for src in work/*/*; do
  case "${src##*.}" in jpg|jpeg|png|JPG|JPEG|PNG) ;; *) continue ;; esac
  out="assets/thumbs/${src#work/}"; out="${out%.*}.jpg"; mkdir -p "$(dirname "$out")"
  if [ ! -f "$out" ] || [ "$src" -nt "$out" ]; then resize "$src" "$out" $W; n=$((n+1)); fi
  webp="${out%.jpg}.webp"
  if [ ! -f "$webp" ] || [ "$out" -nt "$webp" ]; then towebp "$out" "$webp" 2>/dev/null || true; fi
done
echo "thumbs: $n generated/updated"

# Video posters
mkdir -p assets/video-thumbs
grep -oE 'https?://[^ #]+' _data/videos.yml | while read -r url; do
  if [[ "$url" == *vimeo.com* ]]; then
    id="${url##*/}"; id="${id%%\?*}"; out="assets/video-thumbs/vimeo-$id.jpg"
    [ -f "$out" ] && continue
    thumb=$(curl -sfL "https://vimeo.com/api/oembed.json?url=https://vimeo.com/$id&width=1280" | sed -nE 's/.*"thumbnail_url":"([^"]+)".*/\1/p' | sed 's/\\//g')
    [ -n "$thumb" ] && curl -sfL "$thumb" -o "$out" && echo "poster: vimeo $id" || echo "poster: vimeo $id FAILED"
  else
    if [[ "$url" == *v=* ]]; then id="${url##*v=}"; id="${id%%&*}"; else id="${url##*/}"; id="${id%%\?*}"; fi
    out="assets/video-thumbs/yt-$id.jpg"
    [ -f "$out" ] && continue
    curl -sfL "https://i.ytimg.com/vi/$id/maxresdefault.jpg" -o "$out" || curl -sfL "https://i.ytimg.com/vi/$id/hqdefault.jpg" -o "$out" && echo "poster: yt $id" || echo "poster: yt $id FAILED"
  fi
done
