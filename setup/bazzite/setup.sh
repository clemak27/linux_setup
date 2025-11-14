#!/bin/bash

set -eo pipefail

sudo -v

## base

if [ "$HOSTNAME" != "fermi" ]; then
  ujust switch-to-ext4
  ujust setup-luks-tpm-unlock
  hostnamectl hostname fermi
  systemctl reboot
fi

if flatpak list | grep Flatseal &> /dev/null; then flatpak uninstall -y com.github.tchx84.Flatseal; fi

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
