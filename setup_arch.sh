#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation ###
device="/dev/vda"

#------

# Set the keyboard layout
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

# Setup the disk and partitions

parted --script "${device}" -- mklabel gpt \
  mkpart primary fat32 1MiB 261MiB \
  set 1 esp on \
  mkpart primary ext4 261MiB 100%

mkfs.fat -F32 "${device}1"
mkfs.ext4 "${device}2"

mount "${device}2" /mnt/
mkdir -p /mnt/boot/efi
mount "${device}1" /mnt/boot/efi/

# Select the mirrors
cp pacman_mirrorlist /etc/pacman.d/mirrorlist

# Install the base packages
pacstrap /mnt base linux linux-firmware

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab

# install bootloader
arch-chroot /mnt pacman -S --noconfirm grub

arch-chroot /mnt pacman -S --noconfirm efibootmgr intel-ucode
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# setup_system
cp setup_system.sh /mnt/setup_system.sh
arch-chroot /mnt chmod +x setup_system.sh
arch-chroot /mnt ./setup_system.sh
rm /mnt/setup_system.sh

# pick a god and pray
shutdown
