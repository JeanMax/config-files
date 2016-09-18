#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/08/11 14:03:35 by mcanal            #+#    #+#              #
#    Updated: 2016/09/18 14:58:57 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
set -e

CONFIG_FOLDER=~/config-files
TO_LINK="sh_script
.zshrc
.emacs.d
.Xmodmap
.xbindkeysrc"


PRIVATE_FOLDER=private
TO_LINK_PRIVATE=".ssh
.authinfo
.gitconfig"


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
    ln -sbv "$SRC" "$DST"
}

function extract-it () {
    DST="$1"
    SRC="$1.zip"

    back-it "$DST"
    echo "[+] exctract'ed: "
    unzip -d "$CONFIG_FOLDER" "$SRC"
}


for i in $TO_LINK; do
    link-it "$CONFIG_FOLDER/$i" "$HOME/$i"
done
back-it "$HOME/.emacs" # :O

extract-it "$CONFIG_FOLDER/$PRIVATE_FOLDER"
for i in $TO_LINK_PRIVATE; do
    link-it "$CONFIG_FOLDER/$PRIVATE_FOLDER/$i" "$HOME/$i"
done
