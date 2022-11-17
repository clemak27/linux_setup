#!/bin/bash

rpm-ostree install \
  alacritty \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-gsconnect \
  gnome-tweaks \
  vim \
  syncthing \
  wireguard-tools \
  xprop
rpm-ostree override remove firefox firefox-langpacks
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
