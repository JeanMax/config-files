#!/bin/bash

TARGET=/mnt
DEVICE=/dev/sda7

echo -e "-Target: $TARGET"
du -csh $TARGET
echo -e "\n-Device: $DEVICE"
lsblk

echo -e "\nNoot? (y/N)";
read -p "> " ANSWER;
case "$ANSWER" in
    [Yy]|[Yy][Ee][Ss] ) ;;
    * ) exit ;;
esac;

set -xe

# mkfs.ext4 -O "^has_journal" $DEVICE #usb without journaling
current_device="$(lsblk -i | grep bootmnt | sed -E 's|.*(sd\w+)\s.*|/dev/\1|')"
label="$(blkid | grep $current_device | sed -e 's|.*LABEL="(.*)" UUID.*|\1|')"
mkfs.ext4 -v -O ^64bit -L "$label-$(date "+%Y%m")" "$DEVICE"
unset label
unset current_device

mount $DEVICE $TARGET

cp -ax / $TARGET
cp -aT "/run/archiso/bootmnt/arch/boot/$(uname -m)/vmlinuz" $TARGET/boot/vmlinuz-linux

sed -i 's/Storage=volatile/#Storage=auto/' $TARGET/etc/systemd/journald.conf

rm -rf $TARGET/etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount,archiso-start.service,multi-user.target.wants/archiso-start.service}
rm -rf $TARGET/etc/initcpio
rm -f $TARGET/etc/systemd/scripts/choose-mirror
rm -f $TARGET/etc/udev/rules.d/81-dhcpcd.rules
rm -f $TARGET/root/{.automated_script.sh,.zlogin}
rm -f $TARGET/etc/mkinitcpio-archiso.conf

genfstab -U $TARGET >> $TARGET/etc/fstab

arch-chroot $TARGET mkinitcpio -p linux
arch-chroot $TARGET os-prober
arch-chroot $TARGET grub-install --target=i386-pc /dev/sda
arch-chroot $TARGET grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot $TARGET pacman-key --init
arch-chroot $TARGET pacman-key --populate archlinux

# arch-chroot $TARGET systemctl disable pacman-init.service choose-mirror.service || true

echo "NOOT NOOT!"
