#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# printer
pacman -S --noconfirm cups system-config-printer
systemctl enable org.cups.cupsd.service

#------user------

cat <<EOT >> setup_user.sh
yay -S brother-dcpj572dw

EOT
