#!/bin/bash -e

ID="crypt"
# DEFAULT_UUID=9fbe1356-fafc-4c66-8e9d-edc925311555
DEFAULT_UUID=71260df8-dc5e-4391-b953-46d05a1b6ba3


if [ "$1" = mount ]; then
	if [ -z "$3" ]; then

		DEVICE=/dev/$(lsblk -io NAME,UUID \
                     | grep $DEFAULT_UUID \
                     | sed -E 's/.-([^ ]+).*/\1/')
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


# # setup would look like:
# pass=super_safe_password
# dev=/dev/sda4
# crypt_id=super_crypt_id
# target=/mnt

# echo $pass | cryptsetup -v luksFormat --type luks2 $dev
# echo $pass | cryptsetup -v open --type luks2 $dev $crypt_id
# mkfs.ext4 -v /dev/mapper/$crypt_id
# mount -v /dev/mapper/$crypt_id $target

# ls $target

# sync
# umount -v $target
# cryptsetup -v close $crypt_id
