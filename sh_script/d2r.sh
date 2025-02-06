#!/bin/bash

sudo pkill picom

sudo -E su -c '
rtirq start
echo 2048 | tee /proc/sys/dev/hpet/max-user-freq | tee /sys/class/rtc/rtc0/max_user_freq
(cd ~mc/Documents/code/vmread && ./smrfhck) &
while pgrep -f lutris >/dev/null; do
  while ! pgrep D2R >/dev/null; do sleep 5; done;
  touch /tmp/fan.panic
  renice -20 $(pgrep D2R)
  sleep 3
  wmctrl -v -x -r "d2r.exe" -e "0,-2,-2,1600,886"
  while pgrep D2R >/dev/null; do sleep 5; done;
  rm -f /tmp/fan.panic /tmp/ssl.log
done' &
(pgrep lutris || lutris) &

# d2glf | tee -a  ~mc/Documents/code/sniff/sniff.log &
