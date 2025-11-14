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

## homedir

brew bundle install --file "$HOME/Projects/linux_setup/dotfiles/dot_Brewfile"

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
