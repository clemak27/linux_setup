#!/bin/bash

# Manjaro KDE installiert 15.03.2019

# laptop only:
# in der grub config /etc/default/grub zeile auf (aber besser nach diesem script xD)
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1 nouveau.runpm=0"
# ändern für gscheites vsync

sudo pacman -Syyu
sudo pacman -R manjaro-browser-settings ms-office-online

sudo pacman -S yay youtube-dl mpv gimp nextcloud-client keepassxc cmatrix lolcat neofetch ripgrep fzf

sudo pacman -S libreoffice-fresh libreoffice-fresh-de texlive-most

sudo pacman -S git make gcc docker docker-compose jdk8-openjdk maven vim neovim
yay -S vscodium-bin tty-clock

git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global credential.helper "cache --timeout=18000"

code --install-extension akamud.vscode-theme-onedark
code --install-extension dakara.transformer
code --install-extension eamodio.gitlens
code --install-extension ms-python.python
code --install-extension magicstack.magicpython
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension james-yu.latex-workshop

echo "" >> ~/.bashrc
echo "use aliases from file" >> ~/.bashrc
echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
echo "        . ~/.bash_aliases" >> ~/.bashrc
echo "fi" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "use ripgrep with fzf" >> ~/.bashrc
echo "export FZF_DEFAULT_COMMAND='rg --files --hidden'" >> ~/.bashrc

cp vimrc ~/.vimrc
cp bash_aliases ~/.bash_aliases

sudo pacman -S wine-staging lutris

# nextcloud symlinken wenn ordner runtergeladen
# rm ~/Documents/ -R && ln -s ~/Nextcloud/Documents/ ~/Documents
# rm ~/Pictures/ -R && ln -s ~/Nextcloud/Pictures/ ~/Pictures

