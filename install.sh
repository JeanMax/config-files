#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/08/11 14:03:35 by mcanal            #+#    #+#              #
#    Updated: 2017/05/10 17:10:11 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
set -e

CONFIG_FOLDER="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TO_LINK="sh_script
.zshrc
.bashrc
.bash_aliases
.dircolors
.emacs.d
.gdbinit
.gitconfig
.gitignore_global
.Xmodmap
.Xresources
.xinitrc
.xbindkeysrc
.toprc
.config/conky
.config/dconf
.config/gsimplecal
.config/gtk-2.0
.config/gtk-3.0
.config/i3
.config/i3blocks
.config/lxterminal
.config/rofi"

PRIVATE_FOLDER=private
TO_LINK_PRIVATE=".ssh
.authinfo"


function back-it () {
    if [ -e "$1" ]; then
        echo -n "[+] back'ed: "
        "$CONFIG_FOLDER/sh_script/trash.sh" "$1"
    fi
}

function link-it () {
    DST="$2"
    SRC="$1"

    back-it "$DST"
    echo -n "[+] link'ed: "
    ln -sv "$SRC" "$DST"
}

function extract-it () {
    DST="$1"
    SRC="$1.zip"

    back-it "$DST"
    echo "[+] exctract'ed: "
    unzip -d "$CONFIG_FOLDER" "$SRC"
}


mkdir -pv "$HOME/.config"
for i in $TO_LINK; do
    link-it "$CONFIG_FOLDER/$i" "$HOME/$i"
done
back-it "$HOME/.emacs" # :O

if [ "$1" != "--no-private" ]; then
    extract-it "$CONFIG_FOLDER/$PRIVATE_FOLDER"
    for i in $TO_LINK_PRIVATE; do
        link-it "$CONFIG_FOLDER/$PRIVATE_FOLDER/$i" "$HOME/$i"
    done
fi
