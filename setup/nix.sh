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

paru -Rns lolcat cmatrix neofetch sl pipes-rs-git
paru -Rns cava tty-clock ddgr tealdeer
paru -Rns tmuxinator todotxt
paru -Rns ripgrep ranger jq exa hyperfine tokei sd bat ncdu fd bottom git-delta
paru -Rns fzf
rm ~/.go/bin/tea
paru -Rns go gradle jdk11-openjdk maven
paru -Rns nodejs-lts-fermium npm semver typescript yarn
npm i -g npm typescript
paru -Rns insomnia-bin
paru -Rns pgcli github-cli
paru -Rns neovim python-pynvim
# fix ts with uncommenting parasers in config -> TSUninstall all -> renabling parsers

paru -Rns git paru-bin
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

nix-shell '<home-manager>' -A install
ln -sf /home/clemens/Projects/linux_setup/nix /home/clemens/.config/nixpkgs
source ~/.zshrc
home-manager switch
