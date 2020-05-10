#!/bin/bash

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# default programs
pacman -S --noconfirm firefox mpv keepassxc

#------user------

cat <<EOT >> setup_user.sh
yay -S --noconfirm spotify

# mpv config
cp -r /usr/share/doc/mpv/ ~/.config/
sed -i 's/#autofit-larger=90%x90%/autofit-larger=40%x40%/g' ~/.config/mpv/mpv.conf
echo "" >> ~/.config/mpv/mpv.conf
echo 'ytdl-format="bestvideo[height<=?1080]+bestaudio/best"' >> ~/.config/mpv/mpv.conf
echo 'no-keepaspect-window' >> ~/.config/mpv/mpv.conf
echo 'x11-bypass-compositor=no' >> ~/.config/mpv/mpv.conf
EOT
