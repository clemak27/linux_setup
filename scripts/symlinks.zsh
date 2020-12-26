#!/bin/zsh

user=$USER

# i3
mkdir -p /home/$user/.config/i3
ln -sf /home/$user/Projects/linux_setup/i3/config /home/$user/.config/i3/config

# picom
mkdir -p /home/$user/.config/picom
ln -sf /home/$user/Projects/linux_setup/picom/picom.conf /home/$user/.config/picom/picom.conf

# Xresources
ln -sf /home/$user/Projects/linux_setup/Xresources /home/$user/.Xresources

# zsh
ln -sf /home/$user/Projects/linux_setup/zsh/zshrc /home/$user/.zshrc
ln -sf /home/$user/Projects/linux_setup/zsh/starship.toml /home/$user/.starship.toml

# nvim
mkdir -p /home/$user/.config/nvim
ln -sf /home/$user/Projects/linux_setup/nvim/vimrc /home/$user/.config/nvim/init.vim
ln -sf /home/$user/Projects/linux_setup/nvim/coc-settings.json /home/$user/.config/nvim/coc-settings.json

# kitty
mkdir -p /home/$user/.config/kitty
ln -sf /home/$user/Projects/linux_setup/kitty/kitty.conf /home/$user/.config/kitty/kitty.conf

# intelliJ
ln -sf /home/$user/Projects/linux_setup/intelliJ/ideavimrc /home/$user/.ideavimrc

# ranger
mkdir -p /home/$user/.config/ranger
ln -sf /home/$user/Projects/linux_setup/ranger/ranger.rc /home/$user/.config/ranger/rc.conf
ln -sf /home/$user/Projects/linux_setup/ranger/ranger.commands /home/$user/.config/ranger/commands.py

# todo.txt
mkdir -p /home/$user/.todo
ln -sf /home/$user/Projects/linux_setup/todo.sh/todo.cfg /home/$user/.todo/config

# mpv
mkdir -p /home/$user/.config/mpv
ln -sf /home/$user/Projects/linux_setup/mpv/mpv.conf /home/$user/.config/mpv/mpv.conf

# plasma color scheme
mkdir -p /home/$user/.local/share/color-schemes
ln -sf /home/$user/Projects/linux_setup/plasma/Darplasmav.colors /home/$user/.local/share/color-schemes/Darplasmav.colors

# firefox
#ffProfilePath="/home/$user/.mozilla/firefox/72zvuvdy.default-release"
#ln -sf /home/$user/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
#ln -sf /home/$user/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
