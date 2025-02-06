#!/bin/bash


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

main() {
    local updates need_reboot

    # get package list to update, check if there's anything touchy
    updates=$(checkupdates) || {
        echo "~ Up to date! ~"
        exit 0
    }
    grep -Eq 'systemd' <<< "$updates" \
        && need_reboot=systemd
    grep -Eq '(^linux-)|(-dkms$)' <<< "$updates" \
        && need_reboot=y
    echo "$updates"

    # get archlinux news
    yay -Pws

    # system infos
    yay -Ps # TODO: remove if printed with news

    # exit if needed
    if ! test "$FORCE" && test "$need_reboot"; then
	    echo 'Reboot might be needed, use -f/--force if you want to proceed anyway.'
	    exit 42
    fi

    # alph key...
    sudo pacman-key --refresh-keys 0D4D2FDAF45468F3DDF59BEDE3D0D2CD3952E298
    # in case keys are out of date
    yay -Sy --needed alhp-keyring alhp-mirrorlist archlinux-keyring

    # actually update
    yay && yay -Yc  # TODO: handle errors!

    # handle qt bullshit
    grep -q 'qt' <<< "$updates" \
        && yay -S --rebuild qt5-styleplugins

    # clean if needed
    if test "$CLEAN"; then
        sudo pacman -Scc --noconfirm
        sudo find /usr/share/{doc,info,man} \
             /usr/lib/python*/test \
             -mindepth 2 \
             -delete
    fi
    paccache -r  # remove old package cache, keep last 3 versions

    # handle reboot
    if test "$need_reboot"; then
        echo 'Reboot might be needed'

        if test "$REBOOT"; then
            echo "Reboot!"
            sudo systemctl reboot
        elif test "$need_reboot" == systemd; then
            echo "Reexec systemd"
            sudo systemctl daemon-reexec
        fi
    fi
}

arg_parse $@
main
