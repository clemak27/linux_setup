#!/bin/bash

### Setup infomation from user ###
hostname="virtual"
user="cle"
password="1234"
partitions="mbr"
gpu="false"

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

pacman -S --noconfirm vim

# timezone

ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc

# Localization

echo "de_AT.UTF-8" >> /etc/locale.gen
echo "en_GB.UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# Network config

echo "${hostname}" > /etc/hostname

echo "" >> /mnt/etc/hosts
echo "127.0.0.1  localhost" >> /mnt/etc/hosts
echo "::1		localhost" >> /mnt/etc/hosts
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /mnt/etc/hosts
read -n 1 s
# bootloader
pacman -S --noconfirm grub efibootmgr intel-ucode

if [[ $partitions == "mbr" ]]; then
  grub-install --target=i386-pc "${device}"
elif [[ $partitions == "gpt" ]]; then
  grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
fi

grub-mkconfig -o /boot/grub/grub.cfg

# DE
pacman -S --noconfirm xorg-server
localectl set-keymap de
# plasma
echo "Setup KDE Plasma"
pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager
# kde-applications
echo "Setup KDE Applications"
pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind kget khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle

# gpu
if [[ $gpu == "true" ]]; then
  #statements
  echo "To enable multilib repository, uncomment the [multilib] section in /etc/pacman.conf"
  read -n 1 s
  clear
  vim /etc/pacman.conf
	pacman -Syu
  pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings
  pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
fi


# default programs
pacman -S --noconfirm yay youtube-dl mpv keepassxc ripgrep fzf syncthing-gtk mps-youtube
pacman -S --noconfirm cmatrix lolcat neofetch
pacman -S --noconfirm git make gcc docker docker-compose jdk8-openjdk maven neovim nodejs npm yarn python-neovim xclip

# gaming
pacman -S --noconfirm wine-staging lutris

# office
pacman -S --noconfirm gimp libreoffice-fresh libreoffice-fresh-de texlive-most

chmod +x setup_user.sh
su -c ./setup_user.sh $user

# add user and set passwords
pacman -S --noconfirm sudo
useradd -m $user
sudo usermod -aG sudo $user
echo "$user:$password" | chpasswd
echo "root:$password" | chpasswd

# enable systemd modules
systemctl enable sddm
systemctl enable NetworkManager
exit
