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

## podman

systemctl --user enable podman.socket

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
