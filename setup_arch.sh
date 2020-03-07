#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation ###
device="/dev/vda"
passphrase="abcd"

#------

# Set the keyboard layout
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

# Setup the disk and partitions
parted --script "${device}" -- mklabel gpt \
  mkpart primary fat32 1MiB 128MiB \
  set 1 esp on \
  mkpart primary ext4 128MiB 512MiB \
  set 2 boot on \
  mkpart primary ext4 512MiB 100%

# encrypt root
echo -n "${passphrase}" | cryptsetup -v --type luks1 luksFormat "${device}3" -
echo -n "${passphrase}" | cryptsetup open "${device}3" cryptroot -

# create filesystems
mkfs.fat -F32 "${device}1"
mkfs.ext4 "${device}2"
mkfs.ext4 /dev/mapper/cryptroot

# mount partitions
mount /dev/mapper/cryptroot /mnt/
mkdir -p /mnt/efi
mount "${device}1" /mnt/efi
mkdir -p /mnt/boot
mount "${device}2" /mnt/boot/

# Select the mirrors
cp pacman_mirrorlist /etc/pacman.d/mirrorlist

# Install the base packages
pacstrap /mnt base linux linux-firmware grub efibootmgr intel-ucode

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab

# install bootloader
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# setup boot for encrypted device
arch-chroot /mnt sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems fsck)/g' /etc/mkinitcpio.conf
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt sed -i 's,GRUB_CMDLINE_LINUX="",GRUB_CMDLINE_LINUX="cryptdevice='${device}'3:luks:allow-discards",g' /etc/default/grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# setup_system
cp setup_system.sh /mnt/setup_system.sh
arch-chroot /mnt chmod +x setup_system.sh
arch-chroot /mnt ./setup_system.sh
rm /mnt/setup_system.sh
