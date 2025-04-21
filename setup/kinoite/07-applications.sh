#!/bin/bash

set -xueo pipefail

rpm-ostree install --idempotent kontact
flatpak install -y flathub \
  com.calibre_ebook.calibre \
  com.obsproject.Studio \
  hu.irl.cameractrls \
  org.gimp.GIMP \
  org.gimp.GIMP.HEIC \
  org.gimp.GIMP.Plugin.GMic//3 \
  org.kde.haruna \
  org.kde.kid3 \
  org.libreoffice.LibreOffice \
  org.signal.Signal

feishin_version=0.12.3

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
curl -L --url https://github.com/jeffvli/feishin/releases/download/v${feishin_version}/Feishin-${feishin_version}-linux-x86_64.AppImage -o "$HOME/.local/bin/feishin"
chmod +x "$HOME/.local/bin/feishin"
curl -L --url https://raw.githubusercontent.com/jeffvli/feishin/refs/heads/development/assets/icons/128x128.png -o "$HOME/.local/share/applications/feishin.png"
echo -e "[Desktop Entry]\nName=Feishin\nExec=$HOME/.local/bin/feishin\nType=Application\nCategories=Multimedia\nIcon=$HOME/.local/share/applications/feishin.png" > "$HOME/.local/share/applications/feishin.desktop"
