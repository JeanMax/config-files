#!/bin/bash

SIGKILL_DELAY_SEC=2

is_alive() {
	kill -0 $1 > /dev/null 2>&1
}

pid=$(ps hfo pid,cmd -U "$USER" -u "$USER" \
		  | grep -v "killer.sh" \
		  | rofi -dmenu -p "Kill process" -l 10 -width 40% \
		  | sed -E 's! *([0-9]+).*!\1!g')

kill $pid

for i in $(seq $SIGKILL_DELAY_SEC); do
	is_alive $pid || exit 0
	sleep 1;
done
is_alive $pid || exit 0

kill -KILL $pid

is_alive $pid
