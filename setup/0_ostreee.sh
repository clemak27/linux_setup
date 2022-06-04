#!/bin/bash

rpm-ostree install \
  alacritty \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-gsconnect \
  gnome-tweaks \
  neovim \
  syncthing \
  wireguard-tools \
  xclip \
  xprop \
  xrandr
rpm-ostree override remove firefox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
