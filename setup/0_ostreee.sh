#!/bin/bash

rpm-ostree install \
  alacritty \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-gsconnect \
  gnome-tweaks \
  neovim \
  syncthing \
  wireguard-tools \
  xprop
rpm-ostree override remove firefox
systemctl reboot
