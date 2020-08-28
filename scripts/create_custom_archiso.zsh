#!/bin/zsh

sudo pacman -S archiso

sudo cp -r /usr/share/archiso/configs/releng/ archiso
cd archiso
sudo /bin/bash ./build.sh -v -w /tmp/archiso-tmp -o ~/Desktop

sudo pacman -Rns archiso
