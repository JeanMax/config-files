#!/bin/bash
set -e

SCREEN_DIM=$(xdpyinfo | grep 'dimensions:' | cut -f 7 -d ' ')
SCREEN_WIDTH=$(echo "$SCREEN_DIM" | cut -f 1 -d 'x')
SCREEN_HEIGHT=$(echo "$SCREEN_DIM" | cut -f 2 -d 'x')
WIN_DIM=$(xwininfo -all -id "$(xdotool getactivewindow)")
WIN_X=$(echo "$WIN_DIM" | egrep 'Absolute.*X' | cut -d' ' -f7)
# WIN_Y=$(echo "$WIN_DIM" | egrep 'Absolute.*Y' | cut -d' ' -f7)
WIN_WIDTH=$(echo "$WIN_DIM" | grep 'Width' | cut -d' ' -f 4)
# WIN_HEIGHT=$(echo "$WIN_DIM" | grep 'Height' | cut -d' ' -f 4)
# MAX_HORZ=$(echo "$WIN_DIM" | grep 'Maximized Horz')
# MAX_VERT=$(echo "$WIN_DIM" | grep 'Maximized Vert')

function max { # $1="add"/"remove", $2="horz"/"vert"
    wmctrl -r :ACTIVE: -b "$1",maximized_"$2"
}

function resize { # $1=x, $2=y, $3=width, $4=height
    wmctrl -r :ACTIVE: -e 0,"$1","$2","$3","$4"
}


function left {
    max add vert
    max remove horz
    if [ "$WIN_X" = "1" ]; then
        if [ "$(($WIN_WIDTH > $SCREEN_WIDTH/2-10 && $WIN_WIDTH < $SCREEN_WIDTH/2+10))" == "1" ]; then
            resize 0 0 $(($SCREEN_WIDTH*3/4)) -1
            return
        elif [ "$(($WIN_WIDTH > $SCREEN_WIDTH*3/4-10 && $WIN_WIDTH < $SCREEN_WIDTH*3/4+10))" == "1" ]; then
            resize 0 0 $(($SCREEN_WIDTH*1/4)) -1
            return
        fi
    fi
    resize 0 0 $(($SCREEN_WIDTH/2+2)) -1
}

function right {
    max add vert
    max remove horz
    if [ "$(($WIN_X > $SCREEN_WIDTH/2-10 && $WIN_X < $SCREEN_WIDTH/2+10))" == "1" ]; then
        if [ "$(($WIN_WIDTH > $SCREEN_WIDTH/2-10 && $WIN_WIDTH < $SCREEN_WIDTH/2+10))" == "1" ]; then
            resize $(($SCREEN_WIDTH*1/4)) 0 $(($SCREEN_WIDTH*3/4)) -1
            return
        fi
    elif [ "$(($WIN_X > $SCREEN_WIDTH*1/4-10 && $WIN_X < $SCREEN_WIDTH*1/4+10))" == "1" ]; then
        resize $(($SCREEN_WIDTH*3/4)) 0 $(($SCREEN_WIDTH*1/4)) -1
        return
    fi
    resize $(($SCREEN_WIDTH/2)) 0 $(($SCREEN_WIDTH/2)) -1
}


function top-left {
    max remove vert
    max remove horz
    resize 0 0 $(($SCREEN_WIDTH/2)) $(($SCREEN_HEIGHT/2-40))
}

function top-right {
    max remove vert
    max remove horz
    resize $(($SCREEN_WIDTH/2)) 0 $(($SCREEN_WIDTH/2)) $(($SCREEN_HEIGHT/2-40))
}

function bottom-left {
    max remove vert
    max remove horz
    resize 0 $(($SCREEN_HEIGHT/2)) $(($SCREEN_WIDTH/2)) $(($SCREEN_HEIGHT/2-40))
}

function bottom-right {
    max remove vert
    max remove horz
    resize $(($SCREEN_WIDTH/2)) $(($SCREEN_HEIGHT/2)) $(($SCREEN_WIDTH/2)) $(($SCREEN_HEIGHT/2-40))
}

# TODO: learn case bro
if [ "$1" == "-l" ]; then
    left
elif [ "$1" == "-r" ]; then
    right
elif [ "$1" == "-tl" ]; then
    top-left
elif [ "$1" == "-tr" ]; then
    top-right
elif [ "$1" == "-bl" ]; then
    bottom-left
elif [ "$1" == "-br" ]; then
    bottom-right
elif [ "$1" == "-f" ]; then
    max add vert
    max add horz
fi
