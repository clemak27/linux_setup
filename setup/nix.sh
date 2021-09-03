#!/bin/sh

curl -L https://nixos.org/nix/install | sh

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
ln -sf /home/clemens/Projects/nix_setup/nixpkgs /home/clemens/.config/nixpkgs
home-manager switch
source /home/clemens/.zshrc
