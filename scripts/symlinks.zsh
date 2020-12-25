#!/bin/zsh

# i3
mkdir -p ~/.config/i3
ln -sf ~/Projects/linux_setup/i3/config ~/.config/i3/config

# picom
ln -sf ~/Projects/linux_setup/picom/picom.conf ~/.config/picom/picom.conf

# Xresources
ln -sf ~/Projects/linux_setup/Xresources ~/.Xresources

# zsh
ln -sf ~/Projects/linux_setup/zsh/zshrc ~/.zshrc
ln -sf ~/Projects/linux_setup/zsh/starship.toml ~/.starship.toml

# nvim
ln -sf ~/Projects/linux_setup/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/Projects/linux_setup/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# dunst
ln -sf ~/Projects/linux_setup/dunst/dunstrc ~/.config/dunst/dunstrc

# kitty
mkdir -p ~/.config/kitty
ln -sf ~/Projects/linux_setup/kitty/kitty.conf ~/.config/kitty/kitty.conf

# intelliJ
ln -sf ~/Projects/linux_setup/intelliJ/ideavimrc ~/.ideavimrc

# ranger
mkdir -p ~/.config/ranger
ln -sf ~/Projects/linux_setup/ranger/ranger.rc ~/.config/ranger/rc.conf
ln -sf ~/Projects/linux_setup/ranger/ranger.commands ~/.config/ranger/commands.py

# todo.txt
ln -sf ~/Projects/linux_setup/dotfiles/todo.cfg ~/.todo/config

# mpv
ln -sf ~/Projects/linux_setup/dotfiles/mpv.conf ~/.config/mpv/mpv.conf

# kde
mkdir -p ~/.local/share/konsole
mkdir -p ~/.local/share/color-schemes
ln -sf ~/Projects/linux_setup/kde/ZshProfile.profile ~/.local/share/konsole/ZshProfile.profile
ln -sf ~/Projects/linux_setup/kde/DarkDev.colorscheme ~/.local/share/konsole/DarkDev.colorscheme
ln -sf ~/Projects/linux_setup/kde/DarkDev.colors ~/.local/share/color-schemes/DarkDev.colors


# firefox
ffProfilePath="~/.mozilla/firefox/72zvuvdy.default-release"
ln -sf ~/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf ~/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
