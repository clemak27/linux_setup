#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

pacman -S --noconfirm go

#------user------

cat ./go_user.sh >> ./setup_user.sh
