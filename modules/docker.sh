#!/bin/bash

# docker
pacman -S --noconfirm docker docker-compose
systemctl enable docker.service
