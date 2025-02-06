#!/bin/bash

# get package list to update, check if there's anything touchy
UPDATES=$(checkupdates) || exit 0
grep -Eq 'systemd' <<< "$UPDATES" \
    && NEED_REBOOT=systemd
grep -Eq '^linux-' <<< "$UPDATES" \
    && NEED_REBOOT=kernel

package_count=$(wc -l <<< "$UPDATES")


if test "$BLOCK_BUTTON" == "1"; then
    rofi -dmenu -p "Updates" <<< "$UPDATES"
elif test "$BLOCK_BUTTON" == "3"; then
    mate-terminal -x zsh -i -c "$HOME/sh_script/update-arch.sh -f; zsh"
fi

# Variation
if test "$NEED_REBOOT"; then
    color="#cd5542" # red
else
    color="#359859" # green
fi

echo "٨ $package_count" # full text
echo "٨ $package_count" # short text
echo "$color" # color
