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

# ------------------------ ~ ------------------------

# Xresources
ln -sf $config_dir/Xresources $user_dir/.Xresources

# xbindkeysrc 
ln -sf $config_dir/xbindkeysrc $user_dir/.xbindkeysrc

# xprofile
ln -sf $config_dir/xprofile $user_dir/.xprofile

# zsh
ln -sf $config_dir/zshrc $user_dir/.zshrc
ln -sf $config_dir/zsh_functions $user_dir/.zsh_functions
ln -sf $config_dir/starship.toml $user_dir/.starship.toml

# delta
ln -sf $config_dir/delta.config $user_dir/.delta.config

# ideavim.rc
ln -sf $config_dir/ideavimrc $user_dir/.ideavimrc

# tmux
ln -sf $config_dir/tmux.conf $user_dir/.tmux.conf

# npmrc
ln -sf $config_dir/npmrc $user_dir/.npmrc

# ------------------------ .config ------------------------

# alacritty
mkdir -p $user_dir/.config/alacritty
ln -sf $config_dir/alacritty/alacritty.yml $user_dir/.config/alacritty/alacritty.yml

# bat
mkdir -p $user_dir/.config/bat
ln -sf $config_dir/bat/config $user_dir/.config/bat/config

# dunst
mkdir -p $user_dir/.config/dunst
ln -sf $config_dir/dunst/dunstrc $user_dir/.config/dunst/dunstrc

# i3
mkdir -p $user_dir/.config/i3
ln -sf $config_dir/i3/config $user_dir/.config/i3/config

# intelliJ
ln -sf $config_dir/ideavimrc $user_dir/.ideavimrc

# mpv
mkdir -p $user_dir/.config/mpv
ln -sf $config_dir/mpv/mpv.conf $user_dir/.config/mpv/mpv.conf

# nvim
mkdir -p $user_dir/.config/nvim
ln -sf $config_dir/nvim/init.vim $user_dir/.config/nvim/init.vim
ln -sf $config_dir/nvim/lua $user_dir/.config/nvim/lua

# picom
mkdir -p $user_dir/.config/picom
ln -sf $config_dir/picom/picom.conf $user_dir/.config/picom/picom.conf

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
