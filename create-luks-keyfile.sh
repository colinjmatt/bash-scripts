#!/bin/bash
# Encrypted drive keyfile setup on a USB drive for grub2 bootloaders
# TODO
# improve sed inline updates

clear
lsblk
echo ""
USB="$1"
if [[ -z "$USB" ]]; then
    echo -n "Please enter the USB drive identifier (eg: sdb) "
    read -r USB < /dev/tty
fi

clear
lsblk
echo ""
CRYPT="$1"
if [[ -z "$CRYPT" ]]; then
    echo -n "Please enter the encrypted drive identifier (eg: sdb) "
    read -r CRYPT < /dev/tty
fi

pacman -S --noconfirm dosfstools parted

mkdir /mnt/usbkey
parted -s /dev/"$USB" mklabel gpt
parted -s /dev/"$USB" mkpart FAT32
mkfs.vfat /dev/"$USB"
mount /dev/"$USB" /mnt/usbkey

UUID=$(blkid /dev/""$USB"" -o value | sed -n "/msdos/{n;p}")

dd bs=512 count=4 if=/dev/urandom of=/mnt/usbkey/crypt.key iflag=fullblock

clear

echo "Encrypted volume password entry"
echo "========================================================================="
echo ""
cryptsetup luksAddKey /dev/"$CRYPT" /mnt/usbkey/crypt.key --key-slot 1

sed -i "s/MODULES=\"ext4\"/MODULES=\"ext4 nls_cp437 vfat\"/g" /etc/mkinitcpio.conf
mkinitcpio -p linux

sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\ cryptdevice=\/dev\/""$CRYPT"":root\ cryptkey=\/dev\/disk\/by-uuid\/""$UUID"":vfat:\/crypt.key\"/g" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

umount /mnt/usbkey
rm -rf /mnt/usbkey
rm ./keyfile.sh
echo "USB keyfile setup!"
sleep 2
