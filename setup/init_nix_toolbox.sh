#!/bin/bash

cd "$HOME/Projects/linux_setup" || exit 1
sh <(curl -L https://nixos.org/nix/install) --no-daemon
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
. /var/home/clemens/.nix-profile/etc/profile.d/nix.sh
# init home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-env --set-flag priority 0 nix
nix-shell '<home-manager>' -A install
home-manager switch --flake . --impure
nix-channel --remove home-manager
nix-channel --update
rm -rf ~/.config/nixpkgs/home.nix
