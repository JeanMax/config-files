#!/bin/bash

MAIL_COUNT_FILE="$HOME/.mail-count"
MAIL_COUNT=$(< "$MAIL_COUNT_FILE")

if test "$MAIL_COUNT"; then
	echo "✉ $MAIL_COUNT" # full text
	echo "$MAIL_COUNT" # short text
	echo "#528fd1" # color
fi
