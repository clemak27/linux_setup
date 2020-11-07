#!/bin/zsh

setupPath="/home/cle/Projects/linux_setup/"
outPath="/home/cle/Desktop"

sudo pacman -S --noconfirm archiso

sudo cp -r /usr/share/archiso/configs/releng/ /tmp/archiso

sudo cp -r $setupPath /tmp/archiso/airootfs/root/linux_setup
echo 'android-tools' | sudo tee -a /tmp/archiso/packages.x86_64
echo 'neovim' | sudo tee -a /tmp/archiso/packages.x86_64
echo 'git' | sudo tee -a /tmp/archiso/packages.x86_64
echo 'KEYMAP=de-latin1' | sudo tee -a /tmp/archiso/airootfs/etc/vconsole.conf
echo 'alias vim="nvim"' | sudo tee -a /tmp/archiso/airootfs/root/.zshrc

sudo mkarchiso -v -w /tmp/archiso-tmp -o $outPath /tmp/archiso

sudo rm -rf /tmp/archiso /tmp/archiso-tmp

sudo pacman -Rns --noconfirm archiso
