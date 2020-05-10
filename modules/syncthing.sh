#!/bin/bash

echo "Syncthing will be installed as part of the user-setup!"

#------user------

cat <<EOT >> setup_user.sh
yay -S --noconfirm syncthing
yay -S --noconfirm syncthingtray
EOT
