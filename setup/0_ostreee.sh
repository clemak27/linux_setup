#!/bin/bash

rpm-ostree install \
  akmod-nvidia \
  alacritty \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-gsconnect \
  gnome-tweaks \
  neovim \
  syncthing \
  wireguard-tools \
  xclip \
  xorg-x11-drv-nvidia \
  xprop \
  xrandr
rpm-ostree override remove firefox
rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
systemctl reboot
