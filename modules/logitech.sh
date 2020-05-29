#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

#------user------

cat <<EOT >> setup_user.sh
yay -S g810-led-git

EOT
