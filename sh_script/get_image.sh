#!/bin/bash
set -e

DIR=/home/mcanal/Pictures/Wallpapers
IMG=xkcd.png
REQ=/tmp/delme.html

curl -s -X GET xkcd.com > $REQ
rm -f $DIR/$IMG
wget -q $(cat $REQ | egrep -o "http://imgs\.xkcd\.com/.*\.png") -O $DIR/$IMG


TITLE=$(cat $REQ | grep -Po '<img.*title=".*?"' | cut -d'"' -f4 | pandoc -t markdown)
convert $DIR/$IMG -background Red -pointsize 16 label:"$TITLE" -gravity Center -append $DIR/$IMG

# echo "$TITLE" #debug
rm -f $REQ
