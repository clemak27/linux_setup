#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# fonts
pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# default programs
pacman -S --noconfirm firefox mpv keepassxc

# messaging
pacman -S --noconfirm community/telegram-desktop community/signal-desktop

#------user------

cat <<EOT >> setup_user.sh

cd ~/.mozilla/firefox
ff_profile=find . -regextype sed -regex ".*.default-release"
cp -R ff/chrome $ff_profile
cp ff/user.js $ff_profile
cd

yay -S --noconfirm spotify

# mpv config
cp -r /usr/share/doc/mpv/ ~/.config/
sed -i 's/#autofit-larger=90%x90%/autofit-larger=40%x40%/g' ~/.config/mpv/mpv.conf
echo "" >> ~/.config/mpv/mpv.conf
echo 'ytdl-format="bestvideo[height<=?1080]+bestaudio/best"' >> ~/.config/mpv/mpv.conf
echo 'no-keepaspect-window' >> ~/.config/mpv/mpv.conf
echo 'x11-bypass-compositor=no' >> ~/.config/mpv/mpv.conf

EOT
