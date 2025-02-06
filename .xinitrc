#!/bin/sh

# Here i3 is kept as default
export WM=${1:-i3}
# export WM=${1:-sway}

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ "$WM" != "sway" ]; then #TODO: check for wayland instead
    if [ -f $sysmodmap ]; then
        xmodmap $sysmodmap
    fi
fi

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ "$WM" != "sway" ]; then #TODO: check for wayland instead
    if [ -f "$usermodmap" ]; then
        xmodmap "$usermodmap"
    fi
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
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
# setxkbmap -option terminate:ctrl_alt_bksp
# setxkbmap -option caps:super
# these are moved to /etc/X11/xorg.conf.d/20-evdev-custom.conf

export XKB_DEFAULT_LAYOUT=fr,us
export XKB_DEFAULT_VARIANT=, #nodeadkeys
export XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle,
export XKB_DEFAULT_OPTIONS=caps:super

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
# export TERMINAL="urxvtc"
export TERMINAL="mate-terminal"

# this helps rofi-themes
export XDG_DATA_DIRS=/usr/share:/usr/local/share

# this helps... qt. yep
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk2
if grep -q 'style=' ~/.config/Trolltech.conf; then
    sed -i 's/style=.*/style=gtk2/' ~/.config/Trolltech.conf
else
    echo 'style=gtk2' >> ~/.config/Trolltech.conf
fi


# urxvt server
test $TERMINAL == "urxvtc" && urxvtd -q -f -o

# Enable core dumps in case something goes wrong
ulimit -c unlimited

set -x
case $WM in
    i3)

		# Auto screen lock
        xautolock -detectsleep -cornersize 50 -corners --00 -time 10 -locker 'xset dpms force off' &
        # xautolock -detectsleep -cornersize 50 -corners --00 -time 42 -locker 'systemctl suspend -i' &
		# caffeine &
		bash -x "$(command -v lightson+)" --delay 3 --audio 1 --mplayer 1 --vlc 1 --totem 0 --firefox-flash 1 --chromium-flash 1 --webkit-flash 1 --html5 1 --steam 0 --minitube 0 --minload 2 > /tmp/lightson.log 2>&1 &
        # lightson+cmd on &

        screen1=$(xrandr | grep primary)
        screen2=$(xrandr | grep ' connected' | grep -v primary)
        if test "$screen2"; then
            screen1_name=$(echo "$screen1" | cut -d' ' -f1)
            screen2_name=$(echo "$screen2" | cut -d' ' -f1)
            screen1_resolution=$(echo "$screen1" | sed -E 's/.* ([0-9]+x[0-9]+).*/\1/')
            screen2_resolution=$(echo "$screen2" | sed -E 's/.* ([0-9]+x[0-9]+).*/\1/')
            xrandr --output "$screen2_name" --mode "$screen1_resolution" \
                   --output "$screen1_name" --mode "$screen2_resolution" \
                                            --left-of "$screen2_name"
        fi

        pgrep redshift || redshift &

        # Background picture
        # feh -V --bg-max ~/Pictures/Wallpapers/xkcd.png &

		# synaptic daemon to block touchpad while typing
		# syndaemon -i 0.5 -t -K -R -d &

		# compositor
        pgrep picom || picom -CG --backend xrender --xrender-sync-fence --unredir-if-possible --experimental-backends --vsync &

		# numlock at startup
		numlockx &

        # Lock screen at startup
        i3lock -f -t -i ~/Pictures/Wallpapers/xkcd.png

        exec i3;;
	    # Use 25 MiB of RAM for debug logs
	    # exec i3 --shmlog-size=26214400;;

    sway)
        # export GDK_BACKEND=wayland
        export CLUTTER_BACKEND=wayland
        export QT_QPA_PLATFORM=wayland-egl
        export ECORE_EVAS_ENGINE=wayland_egl
        export ELM_ENGINE=wayland_egl
        export SDL_VIDEODRIVER=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1

        exec dbus-launch --sh-syntax --exit-with-session sway -d &> /tmp/sway.log
        # sway -d &> /var/log/sway.log

        ;;

    *) # No known WM, try to run it as command
		echo $WM > /tmp/wm.log
        exec $1;;
esac | tee /tmp/.xinit.log 2>&1
