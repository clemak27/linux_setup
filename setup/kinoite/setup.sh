#!/bin/bash

set -eo pipefail

sudo -v

## base

if [ "$HOSTNAME" = "newton" ]; then
  # shit gpu
  rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
  rpm-ostree kargs \
    --append-if-missing=rd.driver.blacklist=nouveau,nova_core \
    --append-if-missing=modprobe.blacklist=nouveau,nova_core \
    --append-if-missing=nvidia-drm.modeset=1 \
    --append-if-missing=initcall_blacklist=simpledrm_platform_driver_init
fi

## applications

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub
# flatpak list --columns=application,origin | grep fedora | grep -v "org.fedoraproject" | awk '{ print $1 }'
flatpak uninstall -y \
  org.kde.kmahjongg \
  org.kde.kmines \
  org.kde.kolourpaint \
  org.kde.krdc \
  org.kde.skanpage
flatpak install -y --reinstall flathub \
  org.kde.elisa \
  org.kde.gwenview \
  org.kde.kcalc \
  org.kde.okular
flatpak uninstall -y --unused
flatpak remote-delete fedora

## podman

systemctl --user enable podman.socket

## firefox

flatpak install -y flathub \
  org.freedesktop.Platform.ffmpeg-full//24.08 \
  org.mozilla.firefox
flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox

## kde

flatpak install -y flathub \
  com.calibre_ebook.calibre \
  com.github.wwmm.easyeffects \
  com.obsproject.Studio \
  hu.irl.cameractrls \
  org.gimp.GIMP \
  org.gimp.GIMP.HEIC \
  org.gimp.GIMP.Plugin.GMic//3 \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  org.kde.haruna \
  org.kde.kid3 \
  org.libreoffice.LibreOffice \
  org.signal.Signal \
  org.wezfurlong.wezterm
flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0

## openrgb

if [ "$HOSTNAME" = "maxwell" ]; then
  flatpak install -y flathub org.openrgb.OpenRGB
fi

## gaming

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

## brew

brew_version="5.0.0"
brew_dir="/home/linuxbrew/.linuxbrew"

curl -fL -o /tmp/homebrew.tar.gz https://github.com/Homebrew/brew/archive/refs/tags/$brew_version.tar.gz
mkdir -p /tmp/homebrew
tar -xvf /tmp/homebrew.tar.gz -C /tmp/homebrew
sudo mkdir -p "$brew_dir/bin" "$brew_dir/share/zsh/site-functions" "$brew_dir/Cellar"
sudo chown -R 1000:1000 $brew_dir
cp -R -n /tmp/homebrew/brew-$brew_version "$brew_dir/Homebrew"
ln -sf "$brew_dir/Homebrew/bin/brew" "$brew_dir/bin/brew"
ln -sf "$brew_dir/Homebrew/share/zsh/site-functions/_brew" "$brew_dir/share/zsh/site-functions/_brew"
rm -rf /tmp/homebrew /tmp/homebrew.tar.gz

export HOMEBREW_CELLAR=$brew_dir/Cellar
export HOMEBREW_PREFIX=$brew_dir
export HOMEBREW_REPOSITORY=$brew_dir/Homebrew
export HOMEBREW_NO_ANALYTICS=1
export PATH="$brew_dir/bin:$PATH"
brew bundle install --file "$HOME/Projects/linux_setup/dotfiles/dot_Brewfile"

## homedir

mkdir -p "$HOME/.config/chezmoi"
printf "sourceDir: %s/Projects/linux_setup" "$HOME" > "$HOME/.config/chezmoi/chezmoi.yaml"
chezmoi apply --force
mise trust -y
mise install -y

## syncthing

mkdir -p "$HOME/.local/state/syncthing"
systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger

systemctl reboot
