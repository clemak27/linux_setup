#!/bin/bash

xdg-user-dirs-update

# zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global pull.rebase false
git config --global credential.helper cache --timeout=86400

mkdir -p ~/Projects

#yay
cd ~/Projects
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# aur
sudo pacman -S --noconfirm automake autoconf
yay -S --noconfirm cava tty-clock gotop-bin ddgr

# ssh
systemctl --user enable ssh-agent.service
