#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# gaming
pacman -S --noconfirm wine-staging lutris steam discord

#------user------

cat << 'EOT' >> setup_user.sh

yay -S --noconfirm steam-fonts

# kill all gta V processes
# killall -9 -r ".*\.exe|.*SocialClub.*|.*Rockstar.*" && kill -9 $(ps aux | grep '.*PlayGTA.*' | awk '{print $2}')

EOT
