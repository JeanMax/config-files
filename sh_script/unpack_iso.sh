#!/bin/bash -ex

ISO=/root/arch/out/pingulinux-2018.01.17-x86_64.iso
TARGET=/dev/sdb2

MNT_ISO=/mnt/iso
MNT_TARGET=/mnt/target

mkdir -p $MNT_ISO
mount -o loop $ISO $MNT_ISO

e2label $TARGET "$(grep archisolabel $MNT_ISO/arch/boot/syslinux/archiso_sys.cfg | cut -d= -f3)"
parted $(echo $TARGET | sed -E 's|(/dev/.+)([0-9]+)|\1 set \2|') boot on

mkdir -p $MNT_TARGET
mount $TARGET $MNT_TARGET

cp -a $MNT_ISO/* $MNT_TARGET

cp /usr/lib/syslinux/bios/*.c32 $MNT_TARGET/arch/boot/syslinux
extlinux --install $MNT_TARGET/arch/boot/syslinux

sync
for i in $MNT_TARGET $MNT_ISO; do
    umount $i
    rmdir $i
done
