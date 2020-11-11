#!/bin/zsh

# ------------------------ Docker ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ pacman ------------------------
# docker

pacman -S --quiet --noprogressbar --noconfirm docker docker-compose
systemctl enable docker.service

# additional steps

usermod -aG docker $user

# ------------------------ AUR --------------------------

# ------------------------ user -------------------------

# ------------------------ notes ------------------------
