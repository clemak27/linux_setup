#!/bin/bash

# https://zren.github.io/kde/

sudo pacman -R --noconfirm yakuake

sudo pacman -S --noconfirm latte-dock mpd cantata kid3 redshift plasma-browser-integration kvantum-qt5

cp redshift.conf ~/.config/redshift.conf
cp one_dark.colorscheme ~/.local/share/konsole/one_dark.colorscheme

# latte addons
mkdir ~/Projects

sudo pacman -S --noconfirm cmake extra-cmake-modules kwindowsystem kdecoration kcoreaddons

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-title.git
cd applet-window-title
plasmapkg2 -i .

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-buttons.git
cd applet-window-buttons
sh install.sh

cd ~/Projects
git clone https://github.com/psifidotos/applet-window-appmenu.git
cd applet-window-appmenu
sh install.sh

# breeze-gtk theme
sudo pacman -S --noconfirm breeze-gtk

# suru++
cd ~/Projects
wget -qO- https://raw.githubusercontent.com/gusbemacbe/suru-plus/master/install.sh | sh

# meta key latte menu
kwriteconfig5 --file ~/.config/kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu"
qdbus org.kde.KWin /KWin reconfigure

# screen locking bild rein
# window switcher meta
# logout: confirmen, end current session, start with empty
# usermanager bild ändern
# regional format us region, alles ändere österreich
# power management anpassen
