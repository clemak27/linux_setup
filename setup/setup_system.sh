#!/bin/sh

hostname=$(hostname)

passwd

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://nixos.org/channels/nixos-21.05 nixos-stable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

if nix-shell '<home-manager>' -A install
then
  mkdir -p ~/Projects
  cd ~/Projects || exit
  git clone https://github.com/clemak27/linux_setup.git

  if [ -d "../hosts/$hostname" ]
  then
    mv /etc/nixos/hardware-configuration.nix "../hosts/$hostname/hardware-configuration.nix"
    sudo ln -sf "/home/clemens/Projects/linux_setup/hosts/$hostname/configuration.nix" /etc/nixos/configuration.nix
    rm ~/.config/nixpkgs/home.nix
    ln -sf "/home/clemens/Projects/linux_setup/hosts/$hostname/home.nix" /home/clemens/.config/nixpkgs/home.nix
    # TODO uuid?
    # sudo nixos-rebuild boot --upgrade
    # sudo nix-env -f channel:nixos-21.05 -iA sublime-music
    # home-manager switch
  else
    mkdir "../hosts/$hostname"
    mv /etc/nixos/hardware-configuration.nix "../hosts/$hostname/hardware-configuration.nix"
    mv /etc/nixos/configuration.nix "../hosts/$hostname/configuration.nix"
    sudo ln -sf "/home/clemens/Projects/linux_setup/hosts/$hostname/configuration.nix" /etc/nixos/configuration.nix

    echo "initial config generated, now edit hosts/$hostname, then run:"
    echo "sudo nixos-rebuild boot --upgrade"
    echo "sudo nix-env -f channel:nixos-21.05 -iA sublime-music"
    echo "home-manager switch"
  fi
else
  echo "home-manager install failed, try to login again"
fi
