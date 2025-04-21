#!/bin/bash

set -xueo pipefail

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
  curl -sLO \
    --url "https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/JetBrainsMono/Ligatures/$var/JetBrainsMonoNerdFont-$var.ttf"
done
