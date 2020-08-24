#!/bin/zsh

pacman -S archiso

mkdir archiso
cp -r /usr/share/archiso/configs/releng/ archiso
cd archiso

bash ./build.sh -v -w /tmp/archiso-tmp -o /home/cle/Desktop

pacman -Rns archiso
