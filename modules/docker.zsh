#!/bin/zsh

# ------------------------ Docker ------------------------

# docker

pacman -S --noconfirm docker docker-compose
systemctl enable docker.service

# additional steps

usermod -aG docker $user

# ------------------------ AUR --------------------------

# ------------------------ user -------------------------

# ------------------------ notes ------------------------
