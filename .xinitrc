#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Disable DPMS turning off the screen
xset -dpms
xset s off

# Disable bell
xset -b

# Enable zapping (C-A-<Bksp> kills X)
setxkbmap -option terminate:ctrl_alt_bksp

# Enforce correct locales from the beginning:
# LC_ALL is unset since it overwrites everything
unset LC_ALL
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8
export LC_MEASUREMENT=fr_FR.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=fr_FR.UTF-8
export LC_NAME=en_US.UTF-8
export LC_NUMERIC=fr_FR.UTF-8
export LC_PAPER=fr_FR.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_TIME=fr_FR.UTF-8

# This helps i3...
export EDITOR="emacsclient -t"
# export VISUAL="emacsclient -c"
export TERMINAL="urxvtc"
# export TERMINAL="lxterminal"

# urxvt server
test $TERMINAL == "urxvtc" && urxvtd -q -f -o

# Enable core dumps in case something goes wrong
ulimit -c unlimited

# Start emacs server (handling bjorked desktop file)
rm -f ~/.emacs.d/.emacs.desktop.lock
emacs --daemon --eval '(desktop-read)' > /tmp/emacs-startup.log 2>&1 &

# Background picture
feh --bg-max ~/Pictures/Wallpapers/xkcd.png &

# Screen locker
i3lock -t -i ~/Pictures/Wallpapers/xkcd.png && sleep 1
xautolock -time 60 -locker 'i3lock -t -i ~/Pictures/Wallpapers/xkcd.png && sleep 1' &

# Here i3 is kept as default
session=${1:-i3}

case $session in
    i3                ) exec i3;;
    sway              ) exec sway;;
    # No known session, try to run it as command
    *) exec $1;;
esac
