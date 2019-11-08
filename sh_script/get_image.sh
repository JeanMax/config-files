#!/bin/bash
set -ex

DIR=~/Pictures/Wallpapers
IMG=xkcd.png
REQ=/tmp/delme.html

curl -s -X GET https://www.xkcd.com > $REQ
rm -f $DIR/$IMG
wget -q $(grep -Eo "https://imgs\.xkcd\.com/.*\.png" $REQ) -O $DIR/$IMG


TITLE=$(grep -o 'ctitle">.*<' $REQ | sed -E 's|.*>(.*)<|\1|')
SUBTITLE=$(grep -Po '<img.*title=".*?"' $REQ | cut -d'"' -f4)
if hash pandoc 2>/dev/null; then
    TITLE=$(echo "$TITLE" | pandoc -t markdown)
    SUBTITLE=$(echo "$SUBTITLE" | pandoc -t markdown)
fi

# TODO: if there are multiple screens, this might not be the right resolution
RESOLUTION=$(xrandr | grep '*' | head -n1 | sed -E 's/ *([0-9]+x[0-9]+).*/\1/')

convert -depth 8 -resize "$RESOLUTION" $DIR/$IMG -background White -font Code-New-Roman -pointsize 16 -fill Black label:"\n-$TITLE:\n$SUBTITLE\n\n" -gravity Center -append png:$DIR/$IMG

# gsettings set org.gnome.desktop.screensaver picture-uri "file:///home/mc/Pictures/Wallpapers/xkcd.png"
# gsettings set org.gnome.desktop.background picture-uri "file:///home/mc/Pictures/Wallpapers/xkcd.png"
DISPLAY=:0.0 feh -V --bg-max ~/Pictures/Wallpapers/xkcd.png

# echo "$SUBTITLE" #debug
rm -f $REQ
