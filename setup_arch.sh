#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation from user ###
hostname="virtual"
user="cle"
password="1234"
partitions="mbr"
gpu="false"
device="/dev/vda"

### Set up logging ###
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")

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
  mkdir /mnt/efi
  mount "${device}1" /mnt/efi/
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

# chroot
cp setup_chroot.sh /mnt/setup_chroot.sh
cp setup_user.sh /mnt/setup_user.sh
arch-chroot /mnt chmod +x setup_chroot.sh
arch-chroot /mnt ./setup_chroot.sh
rm /mnt/setup_chroot.sh
rm /mnt/setup_user.sh

# pick a god and pray
shutdown 0
