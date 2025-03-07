#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"

rpm-ostree install --idempotent vim make zsh distrobox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# reboot is needed so the base packages are installed
if ! command -v distrobox > /dev/null; then systemctl reboot; fi
sudo usermod -s /usr/bin/zsh clemens
sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/google-chrome.repo

"$host_dir/../../modules/dev/module.sh"
"$host_dir/../../modules/firefox/module.sh"
"$host_dir/../../modules/gaming/module.sh"
"$host_dir/../../modules/git/module.sh"
"$host_dir/../../modules/kde/module.sh"
"$host_dir/../../modules/nvim/module.sh"
"$host_dir/../../modules/podman/module.sh"
"$host_dir/../../modules/syncthing/module.sh"
"$host_dir/../../modules/tools/module.sh"
"$host_dir/../../modules/wezterm/module.sh"
"$host_dir/../../modules/zsh/module.sh"

# git
pubKey=$(cat "$HOME/.ssh/id_ed25519.pub")
git config --global user.email "clemak27@mailbox.org"
git config --global user.name "clemak27"
git config --global user.signingkey "$pubKey"
echo "clemak27@mailbox.org $pubKey" > "$HOME/.ssh/allowed_signers"

# theme
cp "$host_dir/gtk.css" "$HOME/.config/gtk-3.0/gtk.css"
cp "$host_dir/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"

# openrgb
mkdir -p "$HOME/.local/share/applications"
flatpak install -y flathub org.openrgb.OpenRGB
curl -LO "https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage&inline=false"
sudo mv 60-openrgb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

# hw
# kwriteconfig6 "$config_dir/kxkbrc" --group "Layout" --key "LayoutList" "us"
# kwriteconfig6 "$config_dir/kxkbrc" --group "Layout" --key "Use" "true"
# kwriteconfig6 "$config_dir/kxkbrc" --group "Layout" --key "VariantList" "altgr-intl"

# /dev/disk/by-uuid/1d007512-92c1-40ba-8863-f50589b88437 /home/clemens/Games btrfs compress=zstd 0 0
# 192.168.178.100:/media /home/clemens/nfs/media nfs x-systemd.automount,_netdev,x-systemd.idle-timeout=60,noauto 0 0

systemctl reboot
