#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    trash.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/02/12 20:45:01 by mcanal            #+#    #+#              #
#    Updated: 2017/01/31 14:47:56 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

if [ -z $TRASH ]; then
    TRASH=$(test $(uname -s) = "Linux" && echo "$HOME/.local/share/Trash/files" || echo "$HOME/.Trash")
fi

DATE=$(date "+%y-%m-%d_%H-%M-%S")
for i in "$@"; do
	path="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
    dir="$TRASH/$(echo $path | sed 's/\//!/g')@$DATE"
    mkdir -p "$dir"
    mv -vi "$i" "$dir/${i##*/}"
done
