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
ln -sf ~/Projects/linux_setup/rofi/custom.rasi ~/.config/rofi/themes/custom.rasi

# todo.txt
ln -sf ~/Projects/linux_setup/dotfiles/todo.cfg ~/.todo/config

# mpv
ln -sf ~/Projects/linux_setup/dotfiles/mpv.conf ~/.config/mpv/mpv.conf

# kde
mkdir -p /home/$user/.local/share/konsole
mkdir -p /home/$user/.local/share/color-schemes
mkdir -p /home/$user/.config/latte
cp /home/$user/.config/latte/Default.layout.latte /home/$user/.config/latte/Default.bu.layout.latte
ln -sf ~/Projects/linux_setup/kde/ZshProfile.profile /home/$user/.local/share/konsole/ZshProfile.profile
ln -sf ~/Projects/linux_setup/kde/kustom.colorscheme /home/$user/.local/share/konsole/kustom.colorscheme
ln -sf ~/Projects/linux_setup/kde/BreezeDarkCustom.colors /home/$user/.local/share/color-schemes/BreezeDarkCustom.colors
ln -sf ~/Projects/linux_setup/kde/united.layout.latte /home/$user/.config/latte/Default.layout.latte

# firefox
ffProfilePath="~/.mozilla/firefox/72zvuvdy.default-release"
ln -sf ~/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf ~/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
