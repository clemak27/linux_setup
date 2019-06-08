#!/bin/bash

# Manjaro KDE installiert 15.03.2019

# laptop only:
# in der grub config /etc/default/grub zeile auf (aber besser nach diesem script xD)
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1 nouveau.runpm=0"
# ändern für gscheites vsync

sudo pacman -Syyu
sudo pacman -R manjaro-browser-settings ms-office-online

sudo pacman -S yay youtube-dl mpv gimp keepassxc cmatrix lolcat neofetch ripgrep fzf syncthing-gtk

sudo pacman -S git make gcc docker docker-compose jdk8-openjdk maven vim neovim nodejs npm yarn
yay -S vscodium-bin skypeforlinux-stable-bin

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global credential.helper "cache --timeout=18000"

# vs code
code --install-extension akamud.vscode-theme-onedark
code --install-extension dakara.transformer
code --install-extension eamodio.gitlens
code --install-extension ms-python.python
code --install-extension magicstack.magicpython
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension james-yu.latex-workshop

echo "" >> ~/.bashrc
echo "# use aliases from file" >> ~/.bashrc
echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
echo "        . ~/.bash_aliases" >> ~/.bashrc
echo "fi" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "# use ripgrep with fzf" >> ~/.bashrc
echo "export FZF_DEFAULT_COMMAND='rg --files --hidden'" >> ~/.bashrc

cp vimrc ~/.vimrc
cp bash_aliases ~/.bash_aliases

# gaming
sudo pacman -S wine-staging lutris

# office
sudo pacman -S libreoffice-fresh libreoffice-fresh-de texlive-most