#!/bin/bash

set -xueo pipefail

curl -fsLS get.chezmoi.io > chmz
chmod u+x chmz
./chmz -b "$HOME/.local/bin"
rm -f chmz
mkdir -p "$HOME/.config/chezmoi"
printf "sourceDir: %s/Projects/linux_setup" "$HOME" > "$HOME/.config/chezmoi/chezmoi.yaml"
"$HOME/.local/bin/chezmoi" apply
