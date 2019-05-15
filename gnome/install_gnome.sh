#!/bin/bash

# run manjaro default gnome thing first

sudo pacman -S tilix evolution kvantum-qt5

# stand ubuntu 18.10.
sudo pacman -R remove aisleriot cheese gnome-mahjongg gnome-mines remmina shotwell gnome-sudoku thunderbird totem transmission-common

# gnome extensions
sudo pacman -S install gnome-tweak-tool curl
chmod a+x ./gnome-shell-extension-installer.sh
./gnome-shell-extension-installer.sh 15 # alternatetab
./gnome-shell-extension-installer.sh 615 # appindicator-support
./gnome-shell-extension-installer.sh 307 # dash-to-dock
# ./gnome-shell-extension-installer.sh 7 # removable-drive-menu
./gnome-shell-extension-installer.sh 19 # user-themes
./gnome-shell-extension-installer.sh 943 # Workspace Scroll
./gnome-shell-extension-installer.sh 1439 # Never Close Calendar Event
./gnome-shell-extension-installer.sh 657 # ShellTile
./gnome-shell-extension-installer.sh 1319 # GSConnect
# nicht am PC:
# ./gnome-shell-extension-installer.sh 131 # touchpad-indicator

# vimix + kvDark

echo "" >> ~/.bashrc
echo "use kvantum theme engine" >> ~/.bashrc
echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.bashrc

mkdir -p ~/.config/tilix/schemes/
cp one-dark.json ~/.config/tilix/schemes/
