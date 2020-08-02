#!/bin/zsh

# ------------------------ GUI programs ------------------------

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# default programs
pacman -S --noconfirm firefox mpv keepassxc

# messaging
pacman -S --noconfirm signal-desktop

# mpv config
cp -r /usr/share/doc/mpv/ /home/$user/.config/
sed -i 's/#autofit-larger=90%x90%/autofit-larger=40%x40%/g' /home/$user/.config/mpv/mpv.conf
echo "" >> /home/$user/.config/mpv/mpv.conf
echo 'ytdl-format="bestvideo[height<=?1080]+bestaudio/best"' >> /home/$user/.config/mpv/mpv.conf
echo 'no-keepaspect-window' >> /home/$user/.config/mpv/mpv.conf
echo 'x11-bypass-compositor=no' >> /home/$user/.config/mpv/mpv.conf

# user-setup
declare -a user_commands
user_commands=(
  'yay -S --noconfirm spotify'
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