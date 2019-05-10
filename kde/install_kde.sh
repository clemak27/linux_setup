#!/bin/bash

sudo pacman -R yakuake

sudo pacman -S latte-dock mpd cantata kid3 gimp nextcloud-client redshift papirus-icon-theme plasma-browser-integration

cp redshift.conf ~/.config

mkdir -p .local/share/color-schemes/
cp Zion_custom.colors .local/share/color-schemes/
mkdir -p .config/latte/
cp topbar.layout .config/latte/
cp WIM.layout .config/latte/
cp winStyle2019.layout .config/latte/

# plasma theme deepin
# colors zion custom
# icons papirus dark (ändern?)
# gtk style breeze dark, prefer dark, icons auch ändern
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
