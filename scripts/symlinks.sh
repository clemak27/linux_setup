#!/bin/bash

ln -sf ~/Projects/linux_setup/dotfiles/vimrc ~/.config/nvim/init.vim
ln -sf ~/Projects/linux_setup/dotfiles/zshrc ~/.zshrc
ln -sf ~/Projects/linux_setup/dotfiles/p10k ~/.p10k.zsh

ffProfilePath="/home/cle/.mozilla/firefox/72zvuvdy.default-release"

ln -sf ~/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf ~/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
