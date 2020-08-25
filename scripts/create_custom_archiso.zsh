#!/bin/zsh

sudo pacman -S archiso

sudo cp -r /usr/share/archiso/configs/releng/ archiso
cd archiso
ls
sudo /bin/bash ./build.sh -v -w /tmp/archiso-tmp -o /home/cle/Desktop

sudo pacman -Rns archiso
