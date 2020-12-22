#!/bin/zsh

# i3
mkdir -p ~/.config/i3
ln -sf ~/Projects/linux_setup/i3/config ~/.config/i3/config

# Xresources
ln -sf ~/Projects/linux_setup/DarkDev.Xresources ~/.Xresources

# zsh
ln -sf ~/Projects/linux_setup/dotfiles/zshrc ~/.zshrc
ln -sf ~/Projects/linux_setup/dotfiles/starship.toml ~/.starship.toml

# nvim
ln -sf ~/Projects/linux_setup/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/Projects/linux_setup/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# kitty
mkdir -p ~/.config/kitty
ln -sf ~/Projects/linux_setup/dotfiles/kitty.conf ~/.config/kitty/kitty.conf

# intelliJ
ln -sf ~/Projects/linux_setup/dotfiles/ideavimrc ~/.ideavimrc

# ranger
ln -sf ~/Projects/linux_setup/dotfiles/ranger.rc ~/.config/ranger/rc.conf
ln -sf ~/Projects/linux_setup/dotfiles/ranger.commands ~/.config/ranger/commands.py

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
