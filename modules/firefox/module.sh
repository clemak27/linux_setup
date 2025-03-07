#!/bin/bash

set -eo pipefail

bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

__firefox_remove_default() {
  # https://github.com/fedora-silverblue/silverblue-docs/blob/master/modules/ROOT/pages/tips-and-tricks.adoc#hiding-the-default-browser-firefox
  sudo mkdir -p /usr/local/share/applications/
  sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
  sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
  sudo update-desktop-database /usr/local/share/applications/
}

__firefox_install_flatpak() {
  flatpak install -y flathub \
    org.freedesktop.Platform.ffmpeg-full//24.08 \
    org.mozilla.firefox
  flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
  echo 'flatpak run org.mozilla.firefox "$@"' > "$bin_dir/firefox"
  chmod +x "$bin_dir/firefox"
  mkdir -p "$HOME/.local/share/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies"
  cp "$module_dir/policies.json" "$HOME/.local/share/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies/policies.json"
}

__firefox_remove_default
__firefox_install_flatpak
