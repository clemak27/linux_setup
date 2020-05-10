#!/bin/bash

pacman -S --noconfirm python-pip

#------user------

cat <<EOT >> setup_user.sh
# python dev packages
pip install jedi pylint --user
EOT
