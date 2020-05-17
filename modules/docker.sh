#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

cd "${0%/*}"
if [ -f ../config.sh ]; then
    source ../config.sh
else
   echo "Config file could not be found!"
   exit 1
fi

# docker
pacman -S --noconfirm docker docker-compose
systemctl enable docker.service

sudo usermod -aG docker $user
