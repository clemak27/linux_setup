#!/bin/bash

set -eo pipefail

sudo -v

## base

ujust switch-to-ext4
ujust setup-luks-tpm-unlock

hostnamectl hostname fermi

if ! command -v zsh &> /dev/null; then
  rpm-ostree install --idempotent zsh
  systemctl reboot
fi
sudo usermod -s /usr/bin/zsh clemens

if command -v lutris &> /dev/null; then rpm-ostree override remove lutris; fi
if flatpak list | grep Flatseal &> /dev/null; then flatpak uninstall -y com.github.tchx84.Flatseal; fi

sudo mkdir -p /usr/local/share/applications/
sudo cp /usr/share/applications/org.gnome.Ptyxis.desktop /usr/local/share/applications/
sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.gnome.Ptyxis.desktop
sudo update-desktop-database /usr/local/share/applications/

## podman

rpm-ostree install --idempotent podman-docker
sudo mkdir -p /etc/containers
sudo touch /etc/containers/nodocker
systemctl --user enable podman.socket

## firefox

flatpak install -y flathub \
  org.freedesktop.Platform.ffmpeg-full//24.08 \
  org.mozilla.firefox
flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox

## kde

rpm-ostree install --idempotent konsole
flatpak install -y flathub \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark
flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0

## gaming

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

## chezmoi

curl -fsLS get.chezmoi.io > chmz
chmod u+x chmz
./chmz -b "$HOME/.local/bin"
rm -f chmz
mkdir -p "$HOME/.config/chezmoi"
printf "sourceDir: %s/Projects/linux_setup" "$HOME" > "$HOME/.config/chezmoi/chezmoi.yaml"
"$HOME/.local/bin/chezmoi" apply --force

## mise

rpm-ostree install --idempotent gcc-c++
curl https://mise.run | sh
"$HOME/.local/bin/mise" trust
"$HOME/.local/bin/mise" install -y

## syncthing

mkdir -p "$HOME/.local/state/syncthing"
systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger

systemctl reboot
