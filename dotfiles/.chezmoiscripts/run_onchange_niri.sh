#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"

if [ "$XDG_CURRENT_DESKTOP" != "niri" ]; then
  exit 0
fi

gsettings set org.gnome.desktop.wm.preferences button-layout ':close'
gsettings set org.gnome.nautilus.list-view use-tree-view false
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences default-sort-order 'name'
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
