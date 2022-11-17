#!/bin/bash

rpm-ostree install \
  alacritty \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-gsconnect \
  libffi3.1-3.1-32.fc36.x86_64 \
  gnome-tweaks \
  vim \
  syncthing \
  wireguard-tools \
  xclip \
  xprop \
  xrandr
rpm-ostree override remove firefox firefox-langpacks
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
