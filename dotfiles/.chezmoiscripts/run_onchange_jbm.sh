#!/bin/bash

set -eo pipefail

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
