#!/bin/zsh

# ------------------------ GUI programs ------------------------

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# default programs
pacman -S --noconfirm firefox mpv keepassxc

# messaging
pacman -S --noconfirm signal-desktop

# videos
pacman -S --noconfirm obs-studio kdenlive

# rofi
pacman -S --noconfirm rofi rofi-calc dmenu
mkdir -p /home/$user/.config/rofi/themes

# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  'yay -S --noconfirm scrcpy'
  ''
  'yay -S --noconfirm spotify'
  'sudo chmod a+wr /opt/spotify'
  'sudo chmod a+wr /opt/spotify/Apps -R'
  ''
  'yay -S --noconfirm syncthing'
  'yay -S --noconfirm syncthingtray'
  'systemctl --user enable syncthing.service'
  'systemctl --user start syncthing.service'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  echo "$task" >> setup_user.zsh
done
