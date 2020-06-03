#!/bin/bash -e

ID="crypt"
DEFAULT_UUID=50b17450-bf23-4ae6-be1a-29b3b944f57b


if [ "$1" = mount ]; then
	if [ -z "$3" ]; then

		DEVICE=/dev/$(lsblk -io NAME,UUID \
                     | grep $DEFAULT_UUID \
                     | sed -E 's/\|-([^ ]+).*/\1/')
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
