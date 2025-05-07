#!/bin/bash -e

ISO="$1"
DEVICE="$2"

MNT_ISO=/mnt/iso
MNT_DEVICE=/mnt/device

if (( EUID != 0 )); then
	echo "This script should be run as root!" >& 2
	exit 1
fi

echo "-Iso: $ISO"
du -csh "$ISO"
echo -e "\n-Device: $DEVICE"
lsblk
echo
echo -e "\nNoot? (y/N)";
read -p "> " ANSWER;
case "$ANSWER" in
	[Yy]|[Yy][Ee][Ss] ) ;;
	* ) exit ;;
esac;

set -x

mkdir -p $MNT_ISO
mount -o loop "$ISO" $MNT_ISO

# mkfs.ext4 -v "$DEVICE"
# e2label "$DEVICE" "$(grep archisolabel $MNT_ISO/arch/boot/syslinux/archiso_sys.cfg | cut -d= -f3)"
mkfs.ext4 -v -O ^64bit -L "$(grep -o 'archisolabel[^ ]*' $MNT_ISO/arch/boot/syslinux/archiso_sys.cfg | cut -d= -f2)" "$DEVICE"
parted $(echo "$DEVICE" | sed -E 's|(/dev/.+)([0-9]+)|\1 set \2|') boot on

mkdir -p $MNT_DEVICE
mount "$DEVICE" $MNT_DEVICE

cp -a $MNT_ISO/* $MNT_DEVICE

dd bs=440 count=1 conv=notrunc if=/usr/lib/syslinux/bios/mbr.bin of=$(echo "$DEVICE" | sed -E 's|(/dev/.+)([0-9]+)|\1|')
cp /usr/lib/syslinux/bios/*.c32 $MNT_DEVICE/arch/boot/syslinux
extlinux --install $MNT_DEVICE/arch/boot/syslinux

# arch-chroot $MNT_DEVICE systemctl disable dhcpcd.service pacman-init.service choose-mirror.service || true

sync
for i in $MNT_DEVICE $MNT_ISO; do
    umount $i
    rmdir $i
done
