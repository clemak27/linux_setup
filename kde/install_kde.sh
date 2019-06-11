#!/bin/bash

sudo pacman -R --noconfirm yakuake

sudo pacman -S --noconfirm latte-dock mpd cantata kid3 redshift plasma-browser-integration kvantum-qt5

cp redshift.conf ~/.config

mkdir -p .local/share/color-schemes/
cp Zion_custom.colors .local/share/color-schemes/
mkdir -p .config/latte/
cp topbar.layout .config/latte/
cp WIM.layout .config/latte/
cp winStyle2019.layout .config/latte/

# screen locking bild rein
# window switcher meta
# sddm theme chili
# logout: confirmen, end current session, start with empty
# usermanager bild ändern
# regional format us region, alles ändere österreich
# power management anpassen

# für topbar-latte layout
# https://github.com/psifidotos/applet-window-title
# https://github.com/psifidotos/applet-window-buttons
# https://github.com/psifidotos/applet-window-appmenu
