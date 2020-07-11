#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
# https://stackoverflow.com/a/16349776
cd "${0%/*}"
if [ -f ../config.sh ]; then
  source ../config.sh
else
  echo "Config file could not be found!"
  exit 1
fi
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

#------user------

cat ./gui_user.sh >> ./setup_user.sh
