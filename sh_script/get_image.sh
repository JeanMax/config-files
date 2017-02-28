#!/bin/bash
set -ex

DIR=~/Pictures/Wallpapers
IMG=xkcd.png
REQ=/tmp/delme.html

curl -s -X GET https://www.xkcd.com > $REQ
rm -f $DIR/$IMG
wget -q $(cat $REQ | egrep -o "https://imgs\.xkcd\.com/.*\.png") -O $DIR/$IMG


TITLE=$(cat $REQ | grep -Po '<img.*title=".*?"' | cut -d'"' -f4 | pandoc -t markdown)
convert -resize 1200X800 $DIR/$IMG -background White -font Code-New-Roman -pointsize 16 -fill Black label:"\n$TITLE\n\n" -gravity Center -append $DIR/$IMG

# gsettings set org.gnome.desktop.screensaver picture-uri "file:///home/mc/Pictures/Wallpapers/xkcd.png"
# gsettings set org.gnome.desktop.background picture-uri "file:///home/mc/Pictures/Wallpapers/xkcd.png"
DISPLAY=:0.0 feh -V --bg-max ~/Pictures/Wallpapers/xkcd.png

# echo "$TITLE" #debug
rm -f $REQ
