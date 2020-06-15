#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
# https://stackoverflow.com/a/16349776
cd "${0%/*}"
if [ -f ../config.sh ]; then
    source ../config.sh
else
   echo "Config file could not be found!"
   exit 1
fi

# plasma
pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager

# kde-applications
pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind kget khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect partitionmanager krita

# kde-specifics
pacman -S --noconfirm plasma-browser-integration seahorse sshfs unrar libebur128
systemctl enable sddm

# latte-dock
pacman -S --noconfirm latte-dock

# konsole
mkdir -p /home/$user/.local/share/konsole
cp ./kde/ZshProfile.profile /home/$user/.local/share/konsole
cp ./kde/one_custom.colorscheme /home/$user/.local/share/konsole

# colorscheme
mkdir -p /home/$user/.local/share/color-schemes
cp ./kde/BreezeDarkCustom.colors /home/$user/.local/share/color-schemes

cat ./plasma_user.sh >> ./setup_user.sh
