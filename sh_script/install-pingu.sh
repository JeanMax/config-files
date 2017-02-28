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
mkfs.ext4 $DEVICE
mount $DEVICE $TARGET
cp -axv / $TARGET
cp -aTv /run/archiso/bootmnt/arch/boot/$(uname -m)/vmlinuz $TARGET/boot/vmlinuz-linux
genfstab -U $TARGET >> $TARGET/etc/fstab

arch-chroot $TARGET mkinitcpio -p linux
arch-chroot $TARGET os-prober
arch-chroot $TARGET grub-install --target=i386-pc /dev/sda
arch-chroot $TARGET grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot $TARGET sed -i 's/Storage=volatile/#Storage=auto/' /etc/systemd/journald.conf
arch-chroot $TARGET systemctl disable pacman-init.service choose-mirror.service || true
arch-chroot $TARGET rm -rf /etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount} /etc/initcpio
arch-chroot $TARGET rm -f /etc/systemd/scripts/choose-mirror
arch-chroot $TARGET rm -f /etc/udev/rules.d/81-dhcpcd.rules
arch-chroot $TARGET rm -f /root/{.automated_script.sh,.zlogin}
arch-chroot $TARGET rm -f /etc/mkinitcpio-archiso.conf
arch-chroot $TARGET pacman-key --init
arch-chroot $TARGET pacman-key --populate archlinux

echo "NOOT NOOT!"
