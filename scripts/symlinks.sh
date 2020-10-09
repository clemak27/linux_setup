#!/bin/bash

# zsh
ln -sf ~/Projects/linux_setup/dotfiles/zshrc ~/.zshrc
ln -sf ~/Projects/linux_setup/dotfiles/starship.toml ~/.starship.toml

# nvim
ln -sf ~/Projects/linux_setup/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/Projects/linux_setup/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

# intelliJ
ln -sf ~/Projects/linux_setup/dotfiles/ideavimrc ~/.ideavimrc

# ranger
ln -sf ~/Projects/linux_setup/dotfiles/ranger.rc ~/.config/ranger/rc.conf
ln -sf ~/Projects/linux_setup/dotfiles/ranger.commands ~/.config/ranger/commands.py

# rofi
ln -sf ~/Projects/linux_setup/rofi/app.rasi ~/.config/rofi/themes/app.rasi
ln -sf ~/Projects/linux_setup/rofi/colors.rasi ~/.config/rofi/themes/colors.rasi
ln -sf ~/Projects/linux_setup/rofi/onedark.rasi ~/.config/rofi/themes/onedark.rasi

# spicetify
ln -sf ~/Projects/linux_setup/dotfiles/spicetify ~/.config/spicetify/config.ini

# firefox
ffProfilePath="~/.mozilla/firefox/72zvuvdy.default-release"
ln -sf ~/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf ~/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
