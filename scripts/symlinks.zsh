#!/bin/zsh

if [ "$#" -ne 1 ]; then
  user=$USER
else
  user="$1"
fi

# ------------------------ paths ------------------------

setup_dir="/home/$user/Projects/linux_setup"
config_dir="$setup_dir/dotfiles"
user_dir="/home/$user"
ffProfilePath=$(find $user_dir/.mozilla/firefox -name "*.default-release")

# ------------------------ ~ ------------------------

# Xresources
ln -sf $config_dir/Xresources $user_dir/.Xresources

# zsh
ln -sf $config_dir/zshrc $user_dir/.zshrc
ln -sf $config_dir/glab.zsh $user_dir/.glab.zsh
ln -sf $config_dir/curl.zsh $user_dir/.curl.zsh
ln -sf $config_dir/starship.toml $user_dir/.starship.toml

# delta
ln -sf $config_dir/delta.config $user_dir/.delta.config

# ------------------------ .config ------------------------

# bat
mkdir -p $user_dir/.config/bat
ln -sf $config_dir/bat/config $user_dir/.config/bat/config

# glab
mkdir -p $user_dir/.config/glab-cli
ln -sf $config_dir/glab-cli/aliases.yml $user_dir/.config/glab-cli/aliases.yml
ln -sf $config_dir/glab-cli/config.yml $user_dir/.config/glab-cli/config.yml

# i3
mkdir -p $user_dir/.config/i3
ln -sf $config_dir/i3/config $user_dir/.config/i3/config

# intelliJ
ln -sf $config_dir/ideavimrc $user_dir/.ideavimrc

# kitty
mkdir -p $user_dir/.config/kitty
ln -sf $config_dir/kitty/kitty.conf $user_dir/.config/kitty/kitty.conf

# mpv
mkdir -p $user_dir/.config/mpv
ln -sf $config_dir/mpv/mpv.conf $user_dir/.config/mpv/mpv.conf

# nvim
mkdir -p $user_dir/.config/nvim
ln -sf $config_dir/nvim/init.vim $user_dir/.config/nvim/init.vim
ln -sf $config_dir/nvim/coc-settings.json $user_dir/.config/nvim/coc-settings.json

# picom
mkdir -p $user_dir/.config/picom
ln -sf $config_dir/picom/picom.conf $user_dir/.config/picom/picom.conf

# polybar
mkdir -p $user_dir/.config/polybar
ln -sf $config_dir/polybar/config $user_dir/.config/polybar/config

# ranger
mkdir -p $user_dir/.config/ranger
ln -sf $config_dir/ranger/ranger.rc $user_dir/.config/ranger/rc.conf
ln -sf $config_dir/ranger/ranger.commands $user_dir/.config/ranger/commands.py

# redshift
mkdir -p $user_dir/.config/redshift
ln -sf $config_dir/redshift/redshift.conf $user_dir/.config/redshift/redshift.conf

# todo.txt
mkdir -p $user_dir/.todo
ln -sf $config_dir/todo/todo.cfg $user_dir/.todo/config

# spotify-tui
mkdir -p $user_dir/.config/spotify-tui
ln -sf $config_dir/spotify-tui/config.yml $user_dir/.config/spotify-tui/config.yml

# spotifyd
mkdir -p $user_dir/.config/spotifyd
ln -sf $config_dir/spotifyd/spotifyd.conf $user_dir/.config/spotifyd/spotifyd.conf

# ------------------------ .local ------------------------

# plasma color scheme
mkdir -p $user_dir/.local/share/color-schemes
ln -sf $config_dir/plasma/Kustom.colors $user_dir/.local/share/color-schemes/Kustom.colors

# ------------------------ .mozilla ------------------------

# firefox
ln -sf $config_dir/firefox/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
ln -sf $config_dir/firefox/chrome/userContent.css $ffProfilePath/chrome/userContent.css
