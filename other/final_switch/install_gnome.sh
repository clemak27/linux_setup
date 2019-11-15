#!/bin/bash

# remove plasma and kde applications
sudo pacman -Rs --noconfirm bluedevil breeze breeze-gtk kactivitymanagerd kde-cli-tools kde-gtk-config kdecoration kdeplasma-addons kgamma5 khotkeys kinfocenter kmenuedit knetattach kscreen kscreenlocker ksshaskpass ksysguard kwallet-pam kwayland-integration kwin kwrited libkscreen libksysguard milou plasma-browser-integration plasma-desktop plasma-integration plasma-nm plasma-pa plasma-workspace plasma-workspace-wallpapers polkit-kde-agent powerdevil sddm-kcm systemsettings user-manager kget ark dolphin dolphin-plugins ffmpegthumbs filelight gwenview kaccounts-integration kaccounts-providers kamera kate kcalc kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kfind khelpcenter kio-extras konsole ksystemlog kwalletmanager okular print-manager signon-kwallet-extension spectacle kdeconnect latte-dock mpd kid3 plasma-browser-integration seahorse breeze cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons partitionmanager

# gnome
sudo pacman -S --noconfirm baobab eog epiphany evince file-roller gdm gedit gnome-backgrounds gnome-books gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-dictionary gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-maps gnome-menus gnome-photos gnome-remote-desktop gnome-screenshot gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-terminal gnome-themes-extra gnome-todo gnome-user-docs gnome-user-share gnome-video-effects gnome-weather grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb mousetweaks mutter nautilus networkmanager orca rygel sushi tracker tracker-miners vino xdg-user-dirs-gtk yelp simple-scan

sudo systemctl enable gdm.service
sudo systemctl disable sddm.service

# other gnome
sudo pacman -S --noconfirm lollypop kvantum-qt5 tilix gnome-tweaks syncthing-gtk evolution
sudo pacman -Rs --noconfirm gnome-software sddm

# making sure networkmanager stayes installed, otherwise rip
sudo pacman -S --noconfirm networkmanager
sudo systemctl enable NetworkManager

echo "update grub config with nomodeset!!!"
echo "sudo nvim /etc/default/grub"
echo "sudo grub-mkconfig -o /boot/grub/grub.cfg"

# run after reboot

# gnome extensions
# sudo pacman -S --noconfirm gnome-tweak-tool curl

# chmod a+x ./gnome-shell-extension-installer.sh
# # ./gnome-shell-extension-installer.sh 15 # alternatetab
# ./gnome-shell-extension-installer.sh 615 # appindicator-support
# ./gnome-shell-extension-installer.sh 307 # dash-to-dock
# ./gnome-shell-extension-installer.sh 19 # user-themes
# ./gnome-shell-extension-installer.sh 943 # Workspace Scroll
# ./gnome-shell-extension-installer.sh 1319 # GSConnect

# mkdir -p ~/.config/tilix/schemes/
# cp one-dark.json ~/.config/tilix/schemes/

# rm -R ~/.themes/*
# # install vimix-kde and gtk
