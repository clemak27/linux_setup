#!/bin/bash

# gnome
sudo systemctl disable gdm.service

sudo pacman -Rs baobab eog epiphany evince file-roller gdm gedit gnome-backgrounds gnome-books gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-dictionary gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-maps gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-themes-extra gnome-todo gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins mousetweaks mutter nautilus orca rygel sushi tracker tracker-miners vino xdg-user-dirs-gtk yelp simple-scan lollypop kvantum-qt5 tilix gnome-tweaks syncthing-gtk tilix evolution

sudo pacman -S --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager kget ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect latte-dock mpd kid3 redshift plasma-browser-integration kvantum-qt5 seahorse breeze cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons partitionmanager

# making sure syncthing stayes installed
sudo pacman -S --noconfirm syncthing

# making sure networkmanager stayes installed, otherwise rip
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable NetworkManager

# gnome extensions
sudo pacman -Rs --noconfirm gnome-tweak-tool

rm -rf ~/.config/tilix
rm -rf ~/.local/share/gnome-shell

sudo systemctl enable sddm.service
