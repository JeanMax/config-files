#!/bin/bash

is_redshift_up() {
    xrandr --verbose | grep 'Gamma' | grep -q '1.0:1.0:1.0'
}

test "$BLOCK_BUTTON" == 1 && pkill '^redshift$' -USR1

if is_redshift_up; then
    color="#b8b74b" # yellow
    # color="#cd5542" # red
else
    color="#757575" # grey
    # color="#359859" # green
fi

echo "💡" # full text
echo "💡" # short text
echo "$color" # color
