#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation ###
partitions="mbr"
device="/dev/vda"

#------

# Set the keyboard layout
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

# Setup the disk and partitions

if [[ $partitions == "gpt" ]]; then
  parted --script "${device}" -- mklabel gpt \
    mkpart primary fat32 1MiB 261MiB \
    set 1 esp on \
    mkpart primary ext4 261MiB 100%

  mkfs.fat -F32 "${device}1"
  mkfs.ext4 "${device}2"

  mount "${device}2" /mnt/
  mkdir -p /mnt/boot/efi
  mount "${device}1" /mnt/boot/efi/
elif [[ $partitions == "mbr" ]]; then
  parted --script "${device}" -- mklabel msdos \
    mkpart primary ext4 1MiB 100% \
    set 1 boot on

  mkfs.ext4 "${device}1"

  mount "${device}1" /mnt/
else
  echo "partitionscheme not known"
  exit
fi

# Select the mirrors
cp pacman_mirrorlist /etc/pacman.d/mirrorlist

# Install the base packages
pacstrap /mnt base

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab

# install bootloader
arch-chroot /mnt pacman -S --noconfirm grub

if [[ $partitions == "mbr" ]]; then
  arch-chroot /mnt pacman -S --noconfirm intel-ucode
  arch-chroot /mnt grub-install --target=i386-pc ${device}
elif [[ $partitions == "gpt" ]]; then
  arch-chroot /mnt pacman -S --noconfirm efibootmgr amd-ucode
  arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
fi

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# further setup
mkdir -p /mnt/home/cle/linux_setup_usb
cp -R * /mnt/home/cle/linux_setup_usb
arch-chroot /mnt /home/cle/linux_setup_usb/setup_system.sh
rm -rf /mnt/home/cle/linux_setup_usb

# pick a god and pray
shutdown
