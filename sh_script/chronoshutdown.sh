#!/bin/bash

CHRONO=$(test $1 && echo $1 || echo 20)
TMP_SCRIPT=/tmp/chronoshutdown-tmp.sh

cat > $TMP_SCRIPT << EOF
#!/bin/bash

for i in {$CHRONO..1}; do
    echo "shutdown in \$i minutes"
    sleep 60
    clear
done

echo "shutdown now!"
# ~/.config/i3/graceful_exit.sh
# systemctl poweroff -i
i3lock -f -t -i ~/Pictures/Wallpapers/xkcd.png
sleep 1
# systemctl hibernate -i
systemctl suspend -i
EOF
chmod 755 $TMP_SCRIPT

nohup $TMP_SCRIPT > /tmp/chronoshutdown.log 2>&1 &
echo "shutdown in $CHRONO minutes"
