#!/bin/bash

# remove plasma and kde applications
sudo pacman -Rs --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager kget ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect latte-dock mpd cantata kid3 redshift plasma-browser-integration kvantum-qt5 seahorse breeze cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons partitionmanager

sudo systemctl disable sddm

# gnome
sudo pacman -S --noconfirm baobab eog epiphany evince file-roller gdm gedit gnome-backgrounds gnome-books gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-dictionary gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-themes-extra gnome-todo gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mousetweaks mutter nautilus networkmanager orca rygel sushi tracker tracker-miners vino xdg-user-dirs-gtk yelp simple-scan

# pther gnome
pacman -S --noconfirm lollypop kvantum-qt5 tilix gnome-tweaks seahorse sshfs unrar libebur128 kdeconnect

sudo systemctl enable gdm

# making sure networkmanager stay installed, otherwise rip
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable NetworkManager

cd ..
# ONLY WORKS WHEN RUNNING GNOME
# chmod a+x ./gnome/gnome-shell-extension-installer.sh
# ./gnome/gnome-shell-extension-installer.sh 15 # alternatetab
# ./gnome/gnome-shell-extension-installer.sh 615 # appindicator-support
# ./gnome/gnome-shell-extension-installer.sh 307 # dash-to-dock
# ./gnome/gnome-shell-extension-installer.sh 19 # user-themes
# ./gnome/gnome-shell-extension-installer.sh 943 # Workspace Scroll
# ./gnome/gnome-shell-extension-installer.sh 1319 # GSConnect
# ./gnome/gnome-shell-extension-installer.sh 1011 # dynamic panel transparency

mkdir -p ~/.config/tilix/schemes/
cp gnome/tilix-one-dark.json ~/.config/tilix/schemes/

# rm -R ~/.themes/*
# install vimix-kde and gtk
# eventually move these to the appropiate places
