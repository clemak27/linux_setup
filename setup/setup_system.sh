#!/bin/sh

hostname=$(hostname)

passwd

sudo nix-channel --remove nixos
sudo nix-channel --update

if [ -d "../hosts/$hostname" ]; then
  sudo mv /etc/nixos/hardware-configuration.nix "../hosts/$hostname/hardware-configuration.nix"
  sudo mv /etc/nixos/configuration.nix "../hosts/$hostname/initial_configuration_bu.nix"
  rm -rf ~/.config/nixpkgs
else
  echo "no existing config found"
fi
