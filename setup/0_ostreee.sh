#!/bin/bash

rpm-ostree install alacritty neovim syncthing gnome-tweaks gnome-shell-extension-unite gnome-shell-extension-appindicator gnome-shell-extension-gsconnect wireguard-tools
rpm-ostree override remove firefox
systemctl reboot
