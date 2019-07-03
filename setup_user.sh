#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
nvim -c q PluginInstall
nvim -c q call coc#util#install()
nvim -c q CocInstall coc-json coc-tsserver coc-html coc-css coc-yaml coc-python coc-snippets

# aur
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

# 144Hz
# Add MaxFPS=144 to your ~/.config/kwinrc
# Add xrandr --rate 144 to /usr/share/sddm/scripts/Xsetup
# about:config layout.frame_rate 144
