#!/bin/bash

# gnome
sudo pacman -Rs --noconfirm baobab eog evince file-roller gdm gedit gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-dictionary gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-themes-extra gnome-todo gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mousetweaks mutter nautilus networkmanager orca rygel sushi tracker tracker-miners vino xdg-user-dirs-gtk yelp simple-scan lollypop tilix gnome-tweaks syncthing-gtk
sudo systemctl disable gdm

# kde
sudo pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager kget
sudo pacman -S --noconfirm ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect
sudo pacman -S --noconfirm latte-dock mpd cantata kid3 redshift plasma-browser-integration kvantum-qt5 seahorse
sudo pacman -S --noconfirm breeze sddm
sudo pacman -S --noconfirm cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons partitionmanager

sudo systemctl enable sddm

# making sure networkmanager stay installed, otherwise rip
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable NetworkManager

cp ../kde/redshift.conf ~/.conf/

rm -rf ~/.config/tilix

yay -S syncthingtray
yay -S syncthing
