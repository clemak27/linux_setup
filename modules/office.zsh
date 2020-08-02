#!/bin/zsh

# ------------------------ Office Tools ------------------------

# office
pacman -S --noconfirm libreoffice-fresh libreoffice-fresh-de texlive-most

# printer
pacman -S --noconfirm cups system-config-printer
systemctl enable org.cups.cupsd.service

# user-setup
declare -a user_commands
user_commands=(
  'yay -S brother-dcpj572dw'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  echo "$task" >> setup_user.zsh
done