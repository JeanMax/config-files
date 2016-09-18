#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    trash.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/02/12 20:45:01 by mcanal            #+#    #+#              #
#    Updated: 2016/09/10 13:05:22 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

if [ -z $TRASH ]; then
	TRASH=$(test $(uname -s) = "Linux" && echo ~/.local/share/Trash/files || echo ~/.Trash)
fi

DATE=$(date "+%y-%m-%d_%H-%M-%S")
for i in "$@"; do
    dir="$TRASH/$(readlink -f "$i" | sed 's/\//!/g')@$DATE"
    mkdir -p "$dir"
    mv -vi "$i" "$dir/${i##*/}"
done
