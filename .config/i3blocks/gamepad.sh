#!/bin/sh

gamepad_dir=$(find /sys/class/power_supply/ -mindepth 1 2>/dev/null)

test $? = 0 || exit 0
test -d "$gamepad_dir" || exit 0

capacity=$(cat "$gamepad_dir"/capacity)
# status=$(cat "$gamepad_dir"/status)  # Discharging / Charging

# TODO:
# handle multiple controllers
# handle charge status
# use a color code instead of charge percent

if ((capacity < 50)); then
    color="#cd5542" # red
else
    color="#359859" # green
fi

echo "🎮 $capacity" # full text
echo "🎮 $capacity" # short text
echo "$color" # color
