#!/bin/bash

set -eo pipefail

if [ "$HOSTNAME" = "fermi" ]; then
  exit 0
fi

# renovate: datasource=github-tags depName=jeffvli/feishin versioning=loose
feishin_version=1.3.0

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
curl -L --url https://github.com/jeffvli/feishin/releases/download/v${feishin_version}/Feishin-linux-x86_64.AppImage -o "$HOME/.local/bin/feishin"
chmod +x "$HOME/.local/bin/feishin"
curl -L --url https://raw.githubusercontent.com/jeffvli/feishin/refs/heads/development/assets/icons/128x128.png -o "$HOME/.local/share/applications/feishin.png"
echo -e "[Desktop Entry]\nName=Feishin\nExec=$HOME/.local/bin/feishin\nType=Application\nCategories=Multimedia\nIcon=$HOME/.local/share/applications/feishin.png" > "$HOME/.local/share/applications/feishin.desktop"
