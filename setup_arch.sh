#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation from user ###
hostname="virtual"
user="cle"
password="1234"
partitions="mbr"
gpu="false"

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
clear
vim /etc/pacman.d/mirrorlist

# Install the base packages
pacstrap /mnt base

# Configure the system

genfstab -U /mnt >> /mnt/etc/fstab

# chroot

arch-chroot /mnt pacman -S --noconfirm vim

# timezone

arch-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
arch-chroot /mnt hwclock --systohc

# Localization

# Uncomment en_US.UTF-8 UTF-8 and other needed locales
arch-chroot /mnt vim /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt echo "LANG=en_GB.UTF-8" > /etc/locale.conf
arch-chroot /mnt echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# Network config

echo "${hostname}" > /mnt/etc/hostname

echo "" >> /mnt/etc/hosts
echo "127.0.0.1  localhost" >> /mnt/etc/hosts
echo "::1		localhost" >> /mnt/etc/hosts
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /mnt/etc/hosts
read -n 1 s
# bootloader
arch-chroot /mnt pacman -S --noconfirm grub efibootmgr intel-ucode

if [[ $partitions == "mbr" ]]; then
  arch-chroot /mnt grub-install --target=i386-pc "${device}"
elif [[ $partitions == "gpt" ]]; then
  arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
fi

arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg

# DE
arch-chroot /mnt pacman -S --noconfirm xorg-server
# plasma
echo "Setup KDE Plasma"
arch-chroot /mnt pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager
# kde-applications
echo "Setup KDE Applications"
arch-chroot /mnt pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind kget khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle

# gpu
if [[ $gpu == "true" ]]; then
  #statements
  echo "To enable multilib repository, uncomment the [multilib] section in /etc/pacman.conf"
  read -n 1 s
  clear
  arch-chroot /mnt vim /etc/pacman.conf
	arch-chroot /mnt pacman -Syu
  arch-chroot /mnt pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
  arch-chroot /mnt pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
fi

# add user and set passwords
arch-chroot /mnt pacman -S --noconfirm sudo
arch-chroot /mnt useradd -m $user
echo "$user:$password" | chpasswd --root /mnt
echo "root:$password" | chpasswd --root /mnt
clear
arch-chroot /mnt visudo
arch-chroot /mnt pacman -R --noconfirm vim

# enable systemd modules
arch-chroot /mnt systemctl enable sddm
arch-chroot /mnt systemctl enable NetworkManager

# pick a god and pray
shutdown 0
