#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/08/11 14:03:35 by mcanal            #+#    #+#              #
#    Updated: 2016/08/25 18:38:28 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
set -e

CONFIG_FOLDER=~/config-files
TO_LINK="sh_script
.zshrc
.emacs.d
.Xmodmap
.xbindkeysrc"


for i in $TO_LINK; do
    test -e "$HOME/$i" && echo -n "back'ed: " && "$CONFIG_FOLDER/sh_script/trash.sh" "$HOME/$i"
    echo -n "link'ed: "
    ln -sbv "$CONFIG_FOLDER/$i" "$HOME/$i"
done
