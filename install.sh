#!/bin/bash

# Manjaro KDE installiert 19.06.2019

sudo pacman -Syyu
sudo pacman -R manjaro-browser-settings ms-office-online

sudo pacman -S --noconfirm yay youtube-dl mpv keepassxc ripgrep fzf syncthing-gtk mps-youtube

sudo pacman -S --noconfirm cmatrix lolcat neofetch

sudo pacman -S --noconfirm git make gcc docker docker-compose jdk8-openjdk maven neovim nodejs npm yarn python-neovim xclip
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# :call coc#util#install()
# :CocInstall coc-json coc-tsserver coc-html coc-css coc-yaml coc-python coc-snippets

yay -S --noconfirm vscodium-bin skypeforlinux-stable-bin

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global credential.helper "cache --timeout=18000"

# vs code
vscodium --install-extension akamud.vscode-theme-onedark
vscodium --install-extension dakara.transformer
vscodium --install-extension eamodio.gitlens
vscodium --install-extension ms-python.python
vscodium --install-extension magicstack.magicpython
vscodium --install-extension visualstudioexptteam.vscodeintellicode
vscodium --install-extension james-yu.latex-workshop

# gaming
# https://github.com/lutris/lutris/wiki/Installing-drivers
sudo pacman -S --noconfirm wine-staging lutris

# office
sudo pacman -S --noconfirm gimp libreoffice-fresh libreoffice-fresh-de texlive-most
