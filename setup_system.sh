#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

### Setup infomation ###
hostname="virtual"
user="cle"
password="1234"
gpu="false"

#------

# timezone

ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc

# Localization

sed -i 's/#de_AT.UTF-8 UTF-8/de_AT.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# Network config

echo "${hostname}" > /etc/hostname

echo "" >> /etc/hosts
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts

# DE
pacman -S --noconfirm xorg-server fakeroot xdg-user-dirs sudo pkg-config wget

sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf

sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

pacman -Syyu

# plasma
pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager

# kde-applications
pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind kget khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect

# kde-specifics
pacman -S --noconfirm latte-dock mpd cantata kid3 redshift plasma-browser-integration seahorse

systemctl enable sddm

# networkmanager, just to be sure
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

# gpu
if [[ $gpu == "true" ]]; then
  #statements
  pacman -S --noconfirm dkms linux-headers nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
  pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
fi

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji  noto-fonts-extra

# virtualization
# https://computingforgeeks.com/complete-installation-of-kvmqemu-and-virt-manager-on-arch-linux-and-manjaro/
pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
pacman -S --noconfirm ebtables iptables
systemctl enable libvirtd.service
systemctl start libvirtd.service

sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf

newgrp libvirt

# default programs
pacman -S --noconfirm firefox youtube-dl mpv keepassxc ripgrep fzf mps-youtube rsync nextcloud-client

# xD
pacman -S --noconfirm cmatrix lolcat neofetch

# development
pacman -S --noconfirm git make gcc docker docker-compose neovim nodejs npm yarn python-neovim xclip jdk-openjdk intellij-idea-community-edition maven

# gaming
pacman -S --noconfirm wine-staging lutris steam

# office
pacman -S --noconfirm gimp libreoffice-fresh libreoffice-fresh-de texlive-most

# printer
pacman -S --noconfirm cups
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service

# add user and set groups
useradd -m $user
sudo usermod -aG wheel $user
sudo usermod -aG libvirt $user
localectl set-keymap de

# set password
echo "$user:$password" | chpasswd
echo "root:$password" | chpasswd

exit
