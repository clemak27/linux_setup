#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
if [ -f ./config.sh ]; then
    source ./config.sh
else
   echo "Config file could not be found!"
   exit 1
fi

# timezone
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc

# Localization
sed -i 's/#de_AT.UTF-8 UTF-8/de_AT.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# Network config
echo "${hostname}" > /etc/hostname

echo "" >> /etc/hosts
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts

# base packages
pacman -S --noconfirm b43-fwcutter broadcom-wl crda darkhttpd ddrescue dhclient dialog dnsutils elinks ethtool exfat-utils f2fs-tools fsarchiver hdparm ipw2100-fw ipw2200-fw irssi iwd lftp lsscsi mc mtools ndisc6 nfs-utils nilfs-utils nmap ntp openconnect openvpn partclone partimage pptpclient rp-pppoe sdparm sg3_utils tcpdump testdisk usb_modeswitch vpnc wireless-regdb wireless_tools wvdial xl2tpd man

# some important stuff
pacman -S --noconfirm xorg-server fakeroot xdg-user-dirs sudo pkg-config wget ntfs-3g pacman-contrib

# activate multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# grant su permissions to wheel group
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

pacman -Syyu --noconfirm

# plasma
pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager

# kde-applications
pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind kget khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect partitionmanager krita

# kde-specifics
pacman -S --noconfirm latte-dock mpd cantata kid3 plasma-browser-integration seahorse sshfs unrar libebur128
systemctl enable sddm

# networkmanager
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

# gpu
pacman -S --noconfirm mesa
pacman -S --noconfirm dkms linux-headers nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
pacman -S --noconfirm nvidia-prime

# touchpad
pacman -S --noconfirm xf86-input-libinput xf86-input-synaptics

# power management
pacman -S --noconfirm tlp
systemctl enable tlp.service

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# virtualization
# https://computingforgeeks.com/complete-installation-of-kvmqemu-and-virt-manager-on-arch-linux-and-manjaro/
pacman -S --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ovmf
pacman -S --noconfirm ebtables iptables
systemctl enable libvirtd.service

sed -i 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/g' /etc/libvirt/libvirtd.conf
sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/g' /etc/libvirt/libvirtd.conf

# default programs
pacman -S --noconfirm firefox mpv keepassxc

# terminal
pacman -S --noconfirm youtube-dl ripgrep fzf rsync parallel ranger unrar htop arch-audit

# zsh
pacman -S --noconfirm zsh zsh-completions

# xD
pacman -S --noconfirm cmatrix lolcat neofetch sl cloc

# development
pacman -S --noconfirm git make gcc docker docker-compose neovim nodejs npm python-pynvim xclip jdk-openjdk maven python-pip go
systemctl enable docker.service

# gaming
pacman -S --noconfirm wine-staging lutris steam discord

# office
pacman -S --noconfirm libreoffice-fresh libreoffice-fresh-de texlive-most

# printer
pacman -S --noconfirm cups
systemctl enable org.cups.cupsd.service

# enable bluetooth
pacman -S --noconfirm pulseaudio-bluetooth
systemctl enable bluetooth.service

# pacman hooks
mkdir -p /etc/pacman.d/hooks/
cp pacman-hooks/grub.hook /etc/pacman.d/hooks/grub.hook
cp pacman-hooks/cleanup.hook /etc/pacman.d/hooks/cleanup.hook
ln -s /usr/share/arch-audit/arch-audit.hook /etc/pacman.d/hooks/arch-audit.hook

# add user and set groups
useradd -m $user
sudo usermod -aG wheel $user
sudo usermod -aG libvirt $user
sudo usermod -aG docker $user
localectl set-keymap de

# set password
echo "$user:$password" | chpasswd
echo "root:$password" | chpasswd

exit
