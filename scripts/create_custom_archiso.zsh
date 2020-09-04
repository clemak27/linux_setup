#!/bin/zsh

setupPath="~/Projects/linux_setup/"
outPath="~/Desktop"

sudo pacman -S --noconfirm archiso

sudo cp -r /usr/share/archiso/configs/releng/ /tmp/archiso

sudo cp -r $setupPath /tmp/archiso/airootfs/linux_setup

sudo /bin/bash /tmp/archiso/build.sh -v -w /tmp/archiso-tmp -o $outPath

sudo rm -rf /tmp/archiso /tmp/archiso-tmp

sudo pacman -Rns --noconfirm archiso
