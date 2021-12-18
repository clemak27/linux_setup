#!/bin/sh

hostname=$(hostname)

passwd

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://nixos.org/channels/nixos-21.05 nixos-stable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

if nix-shell '<home-manager>' -A install
then
  if [ -d "../hosts/$hostname" ]
  then
    sudo mv /etc/nixos/hardware-configuration.nix "../hosts/$hostname/hardware-configuration.nix"
    sudo mv /etc/nixos/configuration.nix "../hosts/$hostname/initial_configuration_bu.nix"
    sudo ln -sf "/home/clemens/Projects/linux_setup/hosts/$hostname/configuration.nix" /etc/nixos/configuration.nix
    rm -rf ~/.config/nixpkgs
    echo "initial config generated, now edit hosts/$hostname/configuration.nix, then run:"
    echo "sudo nixos-rebuild boot --upgrade"
  else
    echo "no existing config found"
  fi
else
  echo "looks like the home-manager install failed?"
fi
