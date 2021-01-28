#!/bin/zsh

user=$USER

# i3
mkdir -p /home/$user/.config/i3
ln -sf /home/$user/Projects/linux_setup/config/i3/config /home/$user/.config/i3/config

# picom
mkdir -p /home/$user/.config/picom
ln -sf /home/$user/Projects/linux_setup/config/picom/picom.conf /home/$user/.config/picom/picom.conf

# Xresources
ln -sf /home/$user/Projects/linux_setup/Xresources /home/$user/.Xresources

# zsh
ln -sf /home/$user/Projects/linux_setup/config/zsh/zshrc /home/$user/.zshrc
ln -sf /home/$user/Projects/linux_setup/config/zsh/starship.toml /home/$user/.starship.toml

# bat
mkdir -p /home/$user/.config/bat
ln -sf /home/$user/Projects/linux_setup/config/bat/config /home/$user/.config/bat/config

# nvim
mkdir -p /home/$user/.config/nvim
ln -sf /home/$user/Projects/linux_setup/config/nvim/init.vim /home/$user/.config/nvim/init.vim
ln -sf /home/$user/Projects/linux_setup/config/nvim/coc-settings.json /home/$user/.config/nvim/coc-settings.json

# kitty
mkdir -p /home/$user/.config/kitty
ln -sf /home/$user/Projects/linux_setup/config/kitty/kitty.conf /home/$user/.config/kitty/kitty.conf

# intelliJ
ln -sf /home/$user/Projects/linux_setup/config/intelliJ/ideavimrc /home/$user/.ideavimrc

# ranger
mkdir -p /home/$user/.config/ranger
ln -sf /home/$user/Projects/linux_setup/config/ranger/ranger.rc /home/$user/.config/ranger/rc.conf
ln -sf /home/$user/Projects/linux_setup/config/ranger/ranger.commands /home/$user/.config/ranger/commands.py

# todo.txt
mkdir -p /home/$user/.todo
ln -sf /home/$user/Projects/linux_setup/config/todo.sh/todo.cfg /home/$user/.todo/config

# mpv
mkdir -p /home/$user/.config/mpv
ln -sf /home/$user/Projects/linux_setup/config/mpv/mpv.conf /home/$user/.config/mpv/mpv.conf

# plasma color scheme
mkdir -p /home/$user/.local/share/color-schemes
ln -sf /home/$user/Projects/linux_setup/config/plasma/Kustom.colors /home/$user/.local/share/color-schemes/Kustom.colors

# redshift
mkdir -p /home/$user/.config/redshift
ln -sf /home/$user/Projects/linux_setup/config/redshift/redshift.conf /home/$user/.config/redshift/redshift.conf

# spotifyd
mkdir -p /home/$user/.config/spotifyd
ln -sf /home/$user/Projects/linux_setup/config/spotifyd/spotifyd.conf /home/$user/.config/spotifyd/spotifyd.conf

# spotify-tui
mkdir -p /home/$user/.config/spotify-tui
ln -sf /home/$user/Projects/linux_setup/config/spotify-tui/config.yml /home/$user/.config/spotify-tui/config.yml

# firefox
#ffProfilePath="/home/$user/.mozilla/firefox/72zvuvdy.default-release"
#ln -sf /home/$user/Projects/linux_setup/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
#ln -sf /home/$user/Projects/linux_setup/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
