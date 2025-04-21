#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rpm-ostree install --idempotent vim make zsh distrobox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
rpm-ostree install --idempotent https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm
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

# shit gpu
rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init

systemctl reboot
