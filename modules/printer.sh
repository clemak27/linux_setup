#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# printer
pacman -S --noconfirm cups
systemctl enable org.cups.cupsd.service
