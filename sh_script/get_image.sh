#!/bin/bash
set -ex

IMG=~/Pictures/Wallpapers/xkcd.png
FALLBACK_IMG=~/Pictures/serious_lee.jpeg
REQ=$(mktemp)

curl -s https://xkcd.com > $REQ
rm -f $IMG
IMG_URL=$(grep -Eo 'https://imgs\.xkcd\.com/[^"]*\.(png|gif)' $REQ \
              | grep -v "_2x." \
              | head -n1 )
TEMP_IMG="/tmp/$(basename "$IMG_URL")"
wget -q "$IMG_URL" -O "$TEMP_IMG"


TITLE=$(grep -o 'ctitle">.*<' $REQ | sed -E 's|.*>(.*)<|\1|')
SUBTITLE=$(grep -Po '<img.*title=".*?"' $REQ | cut -d'"' -f4)
if hash pandoc 2>/dev/null; then
    TITLE=$(echo "$TITLE" | pandoc -t markdown)
    SUBTITLE=$(echo "$SUBTITLE" | pandoc -t markdown)
fi

if echo "$TEMP_IMG" | grep -q gif ; then
    ffmpeg -i "$TEMP_IMG" /tmp/xkcd-%07d.png
    mv /tmp/xkcd-0000001.png "$TEMP_IMG"
    rm -f /tmp/xkcd-*.png
fi

# TODO: if there are multiple screens, this might not be the right resolution
RESOLUTION=$(xrandr | grep '*' | head -n1 | sed -E 's/.* ([0-9]+x[0-9]+).*/\1/')

convert -depth 8 $(test "$RESOLUTION" && echo -resize "$RESOLUTION") "$TEMP_IMG" -background White -font Code-New-Roman -pointsize 16 -fill Black label:"\n-$TITLE:\n$SUBTITLE\n\n" -gravity Center -append "png:$IMG"

export DISPLAY=:0.0
feh -V --bg-max $IMG || feh -V --bg-max $FALLBACK_IMG

rm -f $REQ "$TEMP_IMG"
