#!/bin/bash

set -xueo pipefail

rpm-ostree install --idempotent --apply-live distrobox vim zsh
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo usermod -s /usr/bin/zsh clemens
sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/google-chrome.repo

if [ "$HOSTNAME" = "newton" ]; then
  # shit gpu
  rpm-ostree install --idempotent https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm
  rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
  rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
fi
