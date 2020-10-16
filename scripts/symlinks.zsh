#!/bin/zsh

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
ln -sf ~/Projects/linux_setup/rofi/combo.rasi ~/.config/rofi/themes/combo.rasi
ln -sf ~/Projects/linux_setup/rofi/powermenu.rasi ~/.config/rofi/themes/powermenu.rasi
ln -sf ~/Projects/linux_setup/rofi/common.rasi ~/.config/rofi/themes/common.rasi

# mpv
ln -sf ~/Projects/linux_setup/dotfiles/mpv.conf ~/.config/mpv/mpv.conf

# firefox
ffProfilePath="~/.mozilla/firefox/72zvuvdy.default-release"
ln -sf ~/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf ~/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
