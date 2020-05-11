#!/bin/bash

# gaming
pacman -S --noconfirm wine-staging lutris steam discord

#------user------

cat <<EOT >> setup_user.sh
yay -S --noconfirm steam-fonts
EOT

