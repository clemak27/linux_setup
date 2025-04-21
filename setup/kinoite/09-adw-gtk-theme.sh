#!/bin/bash

set -xueo pipefail

adw_gtk3_version=5.6

mkdir -p tmp "$HOME/.local/share/themes"
curl -Lo tmp/adw-gtk3.tar.xz --url https://github.com/lassekongo83/adw-gtk3/releases/download/v${adw_gtk3_version}/adw-gtk3v${adw_gtk3_version}.tar.xz
tar xf tmp/adw-gtk3.tar.xz --directory "$HOME/.local/share/themes"
flatpak install flathub -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0
