#!/bin/bash -x

{
old=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
# olders=$(i3-msg -t get_workspaces \
#           | jq '.[] | select(.focused==false).name' \
#           | cut -d"\"" -f2)

ret=$(echo "$old" | cut -d':' -f2 | rofi -dmenu -p "Rename workspace: " -l 6 -width 30%)
new=$(test "$ret" && echo ":$ret")

prefix=$(echo "$old" | cut -d':' -f1)

test "$new" && i3-msg "rename workspace \"$old\" to \"$prefix$new\""
}|&tee /tmp/log
