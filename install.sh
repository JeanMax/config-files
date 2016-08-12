#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/08/11 14:03:35 by mcanal            #+#    #+#              #
#    Updated: 2016/08/11 16:12:53 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
set -e

BACKUP_FOLDER=~/config-backup
CONFIG_FOLDER=~/config-files
TARGET=~
TO_SAVE="sh_script
.zshrc
.emacs
.emacs.d
.xmodmap"

BASIC="\033[0m"
WHITE="\033[37;01m"
RED="\033[31;01m"
GREEN="\033[32;01m"

function backup {
	echo -e $WHITE"Backup:"$BASIC
	mkdir -pv $BACKUP_FOLDER
	DATE=$(date "+%y-%m-%d--%H-%M")
	for i in $TO_SAVE; do
		echo "$TARGET/$i -> $BACKUP_FOLDER/backup_$i@$DATE"
		mv "$TARGET/$i" "$BACKUP_FOLDER/backup_$i@$DATE" || (echo -e "$TARGET/$i: "$RED"fail."$BASIC; exit 42)
	done
	echo
}

function install {
	backup
	echo -e $WHITE"Install:"$BASIC
	for i in $TO_SAVE; do
		echo "$CONFIG_FOLDER/$i -> $TARGET/$i"
		cp -a "$CONFIG_FOLDER/$i" "$TARGET/$i"
	done
	echo
}

function restore {
	backup
	echo -e $WHITE"Restore:"$BASIC
	for i in $TO_SAVE; do
		echo "$BACKUP_FOLDER/backup_$i@$1 -> $TARGET/$i"
		cp -a "$BACKUP_FOLDER/backup_$i@$1" "$TARGET/$i"
	done
	echo
}


if [ "$1" == "--install" ] || [ "$1" == "-i" ]; then
	install
elif [ "$1" == "--restore" ] || [ "$1" == "-r" ]; then
	if [ -n "$2" ]; then
		AT=$2
	else
		AT=$(find $BACKUP_FOLDER -name "backup*" | sort | tail -n1 | cut -d'@' -f2)
		echo -e $RED"Using backup date: $AT\n"$BASIC
	fi
	restore "$AT"
else
	echo "Usage: $0 OPTION"
	echo "-i --install : make a backup then copy config to target." 
	echo "-r --restore [DATE] : make a backup then copy backup from DATE to target." 
	exit 1
fi

echo -e $GREEN"KTHXBYE"$BASIC
