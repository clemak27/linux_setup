#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

pacman -S --noconfirm python-pip

#------user------

cat <<EOT >> setup_user.sh
# python dev packages
pip install jedi pylint --user

EOT
