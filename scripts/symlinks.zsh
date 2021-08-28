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

# xprofile
ln -sf $config_dir/xprofile $user_dir/.xprofile

# Xresources
ln -sf $config_dir/Xresources $user_dir/.Xresources

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

# mpv
mkdir -p $user_dir/.config/mpv
ln -sf $config_dir/mpv/mpv.conf $user_dir/.config/mpv/mpv.conf

# nvim
mkdir -p $user_dir/.config/nvim
ln -sf $config_dir/nvim/init.vim $user_dir/.config/nvim/init.vim
ln -sf $config_dir/nvim/lua $user_dir/.config/nvim/lua

# ranger
mkdir -p $user_dir/.config/ranger
ln -sf $config_dir/ranger/ranger.rc $user_dir/.config/ranger/rc.conf
ln -sf $config_dir/ranger/ranger.commands $user_dir/.config/ranger/commands.py

# tmuxinator
ln -sf $config_dir/tmuxinator $user_dir/.config/tmuxinator

# todo.txt
mkdir -p $user_dir/.todo
ln -sf $config_dir/todo/todo.cfg $user_dir/.todo/config

# ------------------------ .local ------------------------

# plasma color scheme
mkdir -p $user_dir/.local/share/color-schemes
ln -sf $setup_dir/plasma/SkyBlue.colors $user_dir/.local/share/color-schemes/SkyBlue.colors
