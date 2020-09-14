#!/bin/zsh

setupPath="/home/cle/Projects/linux_setup/"
outPath="/home/cle/Desktop"

sudo pacman -S --noconfirm archiso

sudo cp -r /usr/share/archiso/configs/releng/ /tmp/archiso

sudo cp -r $setupPath /tmp/archiso/airootfs/linux_setup
echo 'android-tools' | sudo tee -a /tmp/archiso/packages.x86_64

sudo mkarchiso -v -w /tmp/archiso-tmp -o $outPath /tmp/archiso

sudo rm -rf /tmp/archiso /tmp/archiso-tmp

sudo pacman -Rns --noconfirm archiso
