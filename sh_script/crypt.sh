#!/bin/bash -e

ID="crypt"
DEFAULT_DEVICE=/dev/sdb2


if [ "$1" = mount ]; then
	if [ -z "$3" ]; then
		DEVICE=$DEFAULT_DEVICE
		TARGET="$2"
	else
		DEVICE="$2"
		TARGET="$3"
	fi
	set -x

	cryptsetup open "$DEVICE" $ID
	mount /dev/mapper/$ID "$TARGET"
elif [ "$1" = umount ]; then
	TARGET="$2"
	set -x

	sync
	umount "$TARGET"
	cryptsetup close $ID
fi
