#!/bin/bash

# setup internet connection, then
# run with  curl -sL https://<git-url> | bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation from user ###
hostname="virtarch"
clear

user="c"
clear

password="1234"
clear

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

### Set up logging ###
exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log")

#------

# Set the keyboard layout
loadkeys de-latin1

# Update the system clock
timedatectl set-ntp true

# Setup the disk and partitions

# parted --script "${device}" -- mklabel gpt \
#   mkpart primary fat32 1MiB 261MiB \
#   set 1 esp on \
#   mkpart primary ext4 261MiB 100%

# mkfs.fat -F32 "${device}1"
# mkfs.ext4 "${device}2"

# mount "${device}2" /mnt/
# mkdir /mnt/efi
# mount "${device}1"

parted --script "${device}" -- mklabel msdos \
  mkpart primary ext4 1MiB 100% \
  set 1 boot on

mkfs.ext4 "${device}1"

mount "${device}1" /mnt/

# Select the mirrors

vi /etc/pacman.d/mirrorlist

# Install the base packages
pacstrap /mnt base

# Configure the system

genfstab -U /mnt >> /mnt/etc/fstab

# chroot

arch-chroot /mnt

# timezone

ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc

# Localization

# Uncomment en_US.UTF-8 UTF-8 and other needed locales
vi /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEXMAP=de-latin1" > /etc/vconsole.conf

# Network config

echo "${hostname}" > /etc/hostname

echo "" >> /etc/hosts
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts

# set password
passwd

# bootloader
pacman -S grub efibootmgr intel-ucode
# grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-install --target=i386-pc "${device}"
grub-mkconfig -o /boot/grub/grub.cfg

# arch-chroot /mnt useradd -mU -s /usr/bin/zsh -G wheel,uucp,video,audio,storage,games,input "$user"
# arch-chroot /mnt chsh -s /usr/bin/zsh

# echo "$user:$password" | chpasswd --root /mnt
# echo "root:$password" | chpasswd --root /mnt
