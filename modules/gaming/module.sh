#!/bin/bash

set -eo pipefail

rpm-ostree install --idempotent steam-devices
flatpak install -y flathub \
  com.valvesoftware.Steam \
  com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
  dev.vencord.Vesktop \
  net.lutris.Lutris \
  net.retrodeck.retrodeck \
  org.freedesktop.Platform.VulkanLayer.MangoHud//24.08 \
  org.freedesktop.Platform.VulkanLayer.gamescope//24.08 \
  org.freedesktop.Platform.VulkanLayer.MangoHud//23.08 \
  org.freedesktop.Platform.VulkanLayer.gamescope//23.08 \
  org.freedesktop.Platform.ffmpeg-full//24.08
flatpak --user override --filesystem=~/Games com.valvesoftware.Steam
flatpak --user override --filesystem=~/Games net.retrodeck.retrodeck
flatpak --user override --filesystem=~/Games net.lutris.Lutris
flatpak --user override --filesystem=~/Downloads net.lutris.Lutris
flatpak --user override --nofilesystem=home net.lutris.Lutris
flatpak --user override --nofilesystem=host net.lutris.Lutris
curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
sudo mv 60-steam-input.rules /etc/udev/rules.d/
curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
sudo mv 60-steam-vr.rules /etc/udev/rules.d/
