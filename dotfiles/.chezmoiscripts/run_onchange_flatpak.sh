#!/bin/bash

set -eo pipefail

# yeet fedora

if flatpak remotes | grep fedora > /dev/null; then
  # flatpak list --columns=application,origin | grep fedora | grep -v "org.fedoraproject" | awk '{ print $1 }'
  flatpak remote-delete fedora
fi

# base

flatpak install -y flathub \
  org.freedesktop.Platform.ffmpeg-full//24.08 \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  org.kde.elisa \
  org.kde.gwenview \
  org.kde.kcalc \
  org.kde.okular \
  org.mozilla.firefox

# plasma

if [ "$HOSTNAME" != "fermi" ]; then
  flatpak install -y flathub \
    com.calibre_ebook.calibre \
    com.github.wwmm.easyeffects \
    com.obsproject.Studio \
    hu.irl.cameractrls \
    org.gimp.GIMP \
    org.gimp.GIMP.HEIC \
    org.gimp.GIMP.Plugin.GMic//3 \
    org.kde.haruna \
    org.kde.kid3 \
    org.libreoffice.LibreOffice \
    org.signal.Signal \
    org.wezfurlong.wezterm
fi

flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0

# openrgb

if [ "$HOSTNAME" = "maxwell" ]; then
  flatpak install -y flathub org.openrgb.OpenRGB
fi

# gaming

if [ "$HOSTNAME" != "fermi" ]; then
  flatpak install -y flathub \
    com.valvesoftware.Steam \
    com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
    dev.vencord.Vesktop \
    io.github.Foldex.AdwSteamGtk \
    net.lutris.Lutris \
    net.retrodeck.retrodeck \
    org.freedesktop.Platform.VulkanLayer.MangoHud//25.08 \
    org.freedesktop.Platform.VulkanLayer.gamescope//25.08 \
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
else
  flatpak install -y flathub \
    net.lutris.Lutris \
    net.retrodeck.retrodeck \
    org.freedesktop.Platform.VulkanLayer.MangoHud//23.08 \
    org.freedesktop.Platform.VulkanLayer.MangoHud//24.08 \
    org.freedesktop.Platform.VulkanLayer.gamescope//23.08 \
    org.freedesktop.Platform.VulkanLayer.gamescope//24.08 \
    org.freedesktop.Platform.ffmpeg-full//24.08
  flatpak --user override --filesystem=~/Games net.retrodeck.retrodeck
  flatpak --user override --filesystem=~/Games net.lutris.Lutris
  flatpak --user override --filesystem=~/Downloads net.lutris.Lutris
  flatpak --user override --nofilesystem=home net.lutris.Lutris
  flatpak --user override --nofilesystem=host net.lutris.Lutris
fi
