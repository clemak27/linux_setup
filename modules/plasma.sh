#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# plasma
pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager

# kde-applications
pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind kget khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect partitionmanager krita

# kde-specifics
pacman -S --noconfirm plasma-browser-integration seahorse sshfs unrar libebur128
systemctl enable sddm

#------user------
# https://zren.github.io/kde/

cat <<EOT >> setup_user.sh
# konsole
cp ./kde/ZshProfile.profile ~/.local/share/konsole
cp ./kde/one_black.colorscheme ~/.local/share/konsole
mkdir -p ~/.local/share/color-schemes
cp ./kde/BreezeDarkGrey.colors ~/.local/share/color-schemes

# screen locking change picture
# window switcher meta
# logout: confirm, end current session, start with manually saved
# usermanager change picture
# regional format us region, everything else österreich
# power management anpassen
# autostart: latte, syncthing, keepass

# 144Hz
# Add MaxFPS=144 to your ~/.config/kwinrc under [Compositing]
# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
# about:config layout.frame_rate 144

# intellij: material theme
# kde theme:
# colorscheme for konsole one dark in folder
# colors -> brezze black custom
# plasma theme breeze
# window decorations breeze
# icons candy icons

EOT
