#!/bin/zsh

# ------------------------ Gaming ------------------------

# docker
pacman -S --noconfirm docker docker-compose
systemctl enable docker.service

sudo usermod -aG docker $user
