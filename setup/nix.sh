#!/bin/sh
user="clemens"

# install nix
sudo pacman -S nix
# give user permissions
sudo usermod -aG nix-users $user

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
sudo nix-channel --update

paru -Rns lolcat cmatrix neofetch sl
paru -Rns cava tty-clock ddgr tealdeer
paru -Rns tmuxinator todotxt
paru -Rns ripgrep ranger jq exa hyperfine tokei sd bat ncdu fd bottom git-delta
# paru -Rns fzf

nix-shell '<home-manager>' -A install
ln -sf /home/clemens/Projects/linux_setup/nix $user_dir/.config/nixpkgs
source ~/.zshrc
home-manager switch
