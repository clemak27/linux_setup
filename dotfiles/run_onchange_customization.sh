#!/bin/bash

set -eo pipefail

# adw-gtk3

# renovate: datasource=github-tags depName=lassekongo83/adw-gtk3 versioning=loose
adw_gtk3_version=6.0

mkdir -p /tmp/adw-gtk "$HOME/.local/share/themes"
curl -Lo /tmp/adw-gtk/adw-gtk3.tar.xz --url https://github.com/lassekongo83/adw-gtk3/releases/download/v${adw_gtk3_version}/adw-gtk3v${adw_gtk3_version}.tar.xz
tar xf /tmp/adw-gtk/adw-gtk3.tar.xz --directory "$HOME/.local/share/themes"
rm -rf /tmp/adw-gtk

# papirus

# renovate: datasource=github-tags depName=PapirusDevelopmentTeam/papirus-icon-theme versioning=loose
papirus_version=20250201

wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" EXTRA_THEMES="Papirus-Dark" TAG=$papirus_version sh

## jbm

# renovate: datasource=github-tags depName=ryanoasis/nerd-fonts
jbm_version=3.4.0

mkdir -p "$HOME/.local/share/fonts"
cd "$HOME/.local/share/fonts" || exit 1

variants=(
  "Bold"
  "BoldItalic"
  "ExtraBold"
  "ExtraBoldItalic"
  "ExtraLight"
  "ExtraLightItalic"
  "Italic"
  "Light"
  "LightItalic"
  "Medium"
  "MediumItalic"
  "Regular"
  "SemiBold"
  "SemiBoldItalic"
  "Thin"
  "ThinItalic"
)

for var in "${variants[@]}"; do
  echo "Downloading JetBrainsMonoNerdFont-${var} (${jbm_version})..."
  curl -fsLO \
    --url "https://github.com/ryanoasis/nerd-fonts/raw/refs/tags/v${jbm_version}/patched-fonts/JetBrainsMono/NoLigatures/${var}/JetBrainsMonoNLNerdFont-${var}.ttf"
done
