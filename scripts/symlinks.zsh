#!/bin/zsh

if [ "$#" -ne 1 ]; then
  user=$USER
else
  user="$1"
fi

dotfile_dir="/home/$user/Projects/linux_setup"
user_dir="/home/$user"

# i3
mkdir -p $user_dir/.config/i3
ln -sf $dotfile_dir/i3/config $user_dir/.config/i3/config

# picom
mkdir -p $user_dir/.config/picom
ln -sf $dotfile_dir/picom/picom.conf $user_dir/.config/picom/picom.conf

# Xresources
ln -sf $dotfile_dir/Xresources $user_dir/.Xresources

# zsh
ln -sf $dotfile_dir/zsh/zshrc $user_dir/.zshrc
ln -sf $dotfile_dir/zsh/glab.zsh $user_dir/.glab.zsh
ln -sf $dotfile_dir/zsh/starship.toml $user_dir/.starship.toml

# bat
mkdir -p $user_dir/.config/bat
ln -sf $dotfile_dir/bat/config $user_dir/.config/bat/config

# nvim
mkdir -p $user_dir/.config/nvim
ln -sf $dotfile_dir/nvim/init.vim $user_dir/.config/nvim/init.vim
ln -sf $dotfile_dir/nvim/coc-settings.json $user_dir/.config/nvim/coc-settings.json

# kitty
mkdir -p $user_dir/.config/kitty
ln -sf $dotfile_dir/kitty/kitty.conf $user_dir/.config/kitty/kitty.conf

# glab
mkdir -p $user_dir/.config/glab-cli
ln -sf $dotfile_dir/glab-cli/aliases.yml $user_dir/.config/glab-cli/aliases.yml
ln -sf $dotfile_dir/glab-cli/config.yml $user_dir/.config/glab-cli/config.yml

# delta
ln -sf $dotfile_dir/delta/delta.config $user_dir/.delta.config

# intelliJ
ln -sf $dotfile_dir/intelliJ/ideavimrc $user_dir/.ideavimrc

# ranger
mkdir -p $user_dir/.config/ranger
ln -sf $dotfile_dir/ranger/ranger.rc $user_dir/.config/ranger/rc.conf
ln -sf $dotfile_dir/ranger/ranger.commands $user_dir/.config/ranger/commands.py

# todo.txt
mkdir -p $user_dir/.todo
ln -sf $dotfile_dir/todo.sh/todo.cfg $user_dir/.todo/config

# mpv
mkdir -p $user_dir/.config/mpv
ln -sf $dotfile_dir/mpv/mpv.conf $user_dir/.config/mpv/mpv.conf

# plasma color scheme
mkdir -p $user_dir/.local/share/color-schemes
ln -sf $dotfile_dir/plasma/Kustom.colors $user_dir/.local/share/color-schemes/Kustom.colors

# redshift
mkdir -p $user_dir/.config/redshift
ln -sf $dotfile_dir/redshift/redshift.conf $user_dir/.config/redshift/redshift.conf

# spotifyd
mkdir -p $user_dir/.config/spotifyd
ln -sf $dotfile_dir/spotifyd/spotifyd.conf $user_dir/.config/spotifyd/spotifyd.conf

# spotify-tui
mkdir -p $user_dir/.config/spotify-tui
ln -sf $dotfile_dir/spotify-tui/config.yml $user_dir/.config/spotify-tui/config.yml

# firefox
#ffProfilePath="$user_dir/.mozilla/firefox/72zvuvdy.default-release"
#ln -sf $dotfile_dir/ff/chrome/userChrome.css $ffProfilePath/chrome/userChrome.css
#ln -sf $dotfile_dir/ff/chrome/userContent.css $ffProfilePath/chrome/userContent.css
