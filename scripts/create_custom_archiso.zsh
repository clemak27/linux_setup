#!/bin/zsh

sudo pacman -S archiso

sudo mkdir archiso

sudo cp -r /usr/share/archiso/configs/releng/ archiso
sudo cd archiso

sudo bash ./build.sh -v -w /tmp/archiso-tmp -o /home/cle/Desktop

sudo pacman -Rns archiso
