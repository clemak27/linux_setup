#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

"$host_dir/../../modules/git/module.sh"
"$host_dir/../../modules/tools/module.sh"
"$host_dir/../../modules/zsh/module.sh"

bin_dir="$HOME/.local/bin"

mkdir -p "$HOME/.local/share/konsole"
ln -sf "$host_dir/../../modules/kde/MochaMatte.colorscheme" "$HOME/.local/share/konsole"

# install latest distrobox
mkdir -p "$bin_dir/distrobox"
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix "$HOME/.local/bin/distrobox"
"$HOME/.local/bin/distrobox/bin/distrobox" assemble create --file "$host_dir/box.ini" --name box

mkdir -p "$HOME/.config/systemd/user"
cat << EOF > "$HOME/.config/systemd/user/syncthing.service"
[Install]
WantedBy=default.target

[Service]
ExecStart=/home/deck/.local/bin/syncthing -no-browser -no-restart -no-upgrade '-gui-address=127.0.0.1:8384' '-logflags=0'

[Unit]
After=network.target
Description=Syncthing - Open Source Continuous File Synchronization
Documentation=man:syncthing(1)
EOF

systemctl --user daemon-reload
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

flatpak install --user -y flathub \
  net.lutris.Lutris \
  net.retrodeck.retrodeck \
  org.freedesktop.Platform.VulkanLayer.MangoHud//23.08 \
  org.freedesktop.Platform.VulkanLayer.MangoHud//24.08 \
  org.freedesktop.Platform.VulkanLayer.gamescope//23.08 \
  org.freedesktop.Platform.VulkanLayer.gamescope//24.08 \
  org.freedesktop.Platform.ffmpeg-full//24.08 \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  org.kde.haruna \
  org.mozilla.firefox
