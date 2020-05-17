#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# office
pacman -S --noconfirm libreoffice-fresh libreoffice-fresh-de texlive-most
