#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rpm-ostree install --idempotent vim make zsh distrobox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# reboot is needed so the base packages are installed
if ! command -v distrobox > /dev/null; then systemctl reboot; fi
sudo usermod -s /usr/bin/zsh clemens
sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/google-chrome.repo

"$host_dir/../../modules/firefox/module.sh"
"$host_dir/../../modules/gaming/module.sh"
"$host_dir/../../modules/kde/module.sh"
"$host_dir/../../modules/podman/module.sh"
"$host_dir/../../modules/syncthing/module.sh"
"$host_dir/../../modules/wezterm/module.sh"

# openrgb
mkdir -p "$HOME/.local/share/applications"
flatpak install -y flathub org.openrgb.OpenRGB
curl -LO "https://openrgb.org/releases/release_0.9/60-openrgb.rules"
sudo mv 60-openrgb.rules /etc/udev/rules.d/
sudo restorecon /etc/udev/rules.d/60-openrgb.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

mkdir -p "$HOME/.config/autostart"
cat << EOF > "$HOME/.config/autostart/openrgb.sh.desktop"
[Desktop Entry]
Exec=$HOME/Projects/linux_setup/hosts/maxwell/openrgb.sh
Icon=application-x-shellscript
Name=openrgb.sh
Type=Application
X-KDE-AutostartScript=true
EOF

# 192.168.178.100:/media /home/clemens/nfs/media nfs x-systemd.automount,_netdev,x-systemd.idle-timeout=60,noauto 0 0
# systemctl daemon-reload

systemctl reboot
