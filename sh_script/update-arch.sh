#!/bin/bash -x

(test "$1" == "-f" || test "$1" == "--force") \
        && FORCE=t


COOKIE=/tmp/.yay.cookie
yes no | yay |& tee "$COOKIE"
grep -Eq 'linux-[0-9]|linux-headers|systemd' "$COOKIE" \
    && NEED_REBOOT=t
rm -f "$COOKIE"

if ! test "$FORCE" && test "$NEED_REBOOT"; then
	echo 'Reboot might be needed, use -f/--force if you want to proceed anyway.'
	exit 42
fi

yay -Su --cleanafter \
    && yay -c \
    && sudo pacman -Scc --noconfirm \
    && (test "$NEED_REBOOT" \
            && sudo systemctl reboot)


# && sudo rm -rf /usr/share/{doc,info,man}/* \
