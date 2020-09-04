#!/bin/bash

ln -sf ~/Projects/linux_setup/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/Projects/linux_setup/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf ~/Projects/linux_setup/dotfiles/zshrc ~/.zshrc
ln -sf ~/Projects/linux_setup/dotfiles/starship.toml ~/.starship.toml
ln -sf ~/Projects/linux_setup/dotfiles/ideavimrc ~/.ideavimrc

ln -sf ~/Projects/linux_setup/dotfiles/spicetify ~/.config/spicetify/config.ini

ffProfilePath="~/.mozilla/firefox/72zvuvdy.default-release"

ln -sf ~/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf ~/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
