#!/bin/bash

COOKIE=/tmp/.yay.cookie


usage() {
    this_script="$1"
    error="$2"
    test "$error" && echo
    cat << EOF 2>&1
Usage:
  $this_script [OPTION]...

Upgrade arch-linux packages.

Options:
  -c, --clean   clean package cache and documentation after upgrade
  -f, --force   upgrade packages even if a reboot might be needed
  -r, --reboot  reboot after upgrade if needed
  -h, --help    display this help
EOF
    exit $(test "$error" && echo 42 || echo 0)
}

arg_parse() {
    args=$(getopt --options "-cfrh" \
                  --longoptions "clean,force,reboot,help" \
                  --name "$0" -- $*)
    test $? = 0 || usage $0 --error
    set -- $args
    while true; do
        case "$1" in
            --)
                shift
                break
                ;;
            # -o)
            #     shift
            #     O_ARG="$1"
            #     ;;
            -c|--clean)
                CLEAN=t
                ;;
            -f|--force)
                FORCE=t
                ;;
            -r|--reboot)
                REBOOT=t
                ;;
            -h|--help)
                usage $0
                ;;
            *)
                usage $0 --error
                ;;
        esac
        shift
    done
}


arg_parse $@

yay -Pw
yes no | yay |& tee "$COOKIE"
grep -Eq 'linux-[0-9]|linux-headers|systemd' "$COOKIE" \
    && NEED_REBOOT=t
rm -f "$COOKIE"

if ! test "$FORCE" && test "$NEED_REBOOT"; then
	echo 'Reboot might be needed, use -f/--force if you want to proceed anyway.'
	exit 42
fi

yay && yay -c
if test "$CLEAN"; then
    sudo pacman -Scc --noconfirm
    sudo find /usr/share/{doc,info,man} \
         /usr/lib/python*/test \
         -mindepth 2 \
         -delete
fi
if test "$NEED_REBOOT"; then
    echo 'Reboot might be needed'
    test "$REBOOT" && sudo systemctl reboot
fi
