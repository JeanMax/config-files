#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tab_cd.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/08/19 13:33:30 by mcanal            #+#    #+#              #
#    Updated: 2017/01/30 15:19:11 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ -n "$2" ]; then
    \cd $1 $2;
    echo -ne "\033]0;$USER@$HOST:${PWD/$HOME/~}\007";
elif [ -z "$1" ];then
    \cd;
    echo -ne "\033]0;$USER@$HOST:~\007";
elif [ ! -d "$1" -a "$1" != "-" ]; then
    echo "I'm pretty sure you're stoned again...";
else
    \cd $1;
    echo -ne "\033]0;$USER@$HOST:${PWD/$HOME/~}\007";
fi;
