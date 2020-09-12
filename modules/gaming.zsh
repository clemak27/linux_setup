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
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  echo "$task" >> setup_user.zsh
done

# ------------------------ Notes ------------------------

# kill all gta V processes
# killall -9 -r ".*\.exe|.*SocialClub.*|.*Rockstar.*" && kill -9 $(ps aux | grep '.*PlayGTA.*' | awk '{print $2}')
#
# I've fixed this issue by changing the pointing launcher link of the game.
# Actually in steam the game is launched through the gameguide launcher that causes some troubles. Indeed, the gameguide launcher works but the play button in it won't launch the game.
# So to start it directly from the game launcher instead of the gameguide launcher, go to steam/common/Sid Meier's Civilization VI/ and edit "Civ6" file and change the line "./GameGuide/Civ6" to "./Civ6Sub"
