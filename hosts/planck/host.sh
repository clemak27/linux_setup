#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

config_dir="$HOME/.config"

if [[ -z "$TERMUX_VERSION" ]]; then
  echo "not running on termux"
  exit 1
fi

# termux-change-repo
# pkg install -y git zsh make build-essential
# mkdir -p .config ~/Projects
# cd Projects
# git clone https://github.com/clemak27/linux_setup
# cd linux_setup
# ./hosts/planck/host.sh

pkg install -y git git-delta lazygit
"$host_dir/../../modules/git/module.sh"

pkg install -y zsh starship zsh-completions
"$host_dir/../../modules/zsh/module.sh"
chsh -s zsh

mkdir -p "$HOME/.termux"
ln -sf "$host_dir/colors.properties" "$HOME/.termux/colors.properties"

pkg install -y bat eza fd fzf htop jq yazi ripgrep sd tealdeer tree unrar unzip
"$host_dir/../../modules/tools/module.sh"

curl -L \
  --url https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFontMono-Regular.ttf \
  -o "$HOME/.termux/font.ttf"
