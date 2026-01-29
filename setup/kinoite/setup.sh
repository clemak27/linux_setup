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

## brew

brew_dir="/home/linuxbrew/.linuxbrew"

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
