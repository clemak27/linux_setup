#!/bin/zsh

# ------------------------ Gaming ------------------------

# gaming
pacman -S --noconfirm wine-staging lutris steam discord obs-studio

# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  'yay -S --noconfirm steam-fonts'
  ''
  '# kill all gta V processes'
  '# killall -9 -r ".*\.exe|.*SocialClub.*|.*Rockstar.*" && kill -9 $(ps aux | grep '.*PlayGTA.*' | awk '{print $2}')'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  echo "$task" >> setup_user.zsh
done