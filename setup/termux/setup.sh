#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

if [[ -z "$TERMUX_VERSION" ]]; then
  echo "not running on termux"
  exit 1
fi

# termux-change-repo
# pkg install -y git
# mkdir -p .config ~/Projects
# cd Projects
# git clone https://github.com/clemak27/linux_setup
# cd linux_setup
# ./setup/termux/host.sh

pkg install -y git git-delta lazygit
pkg install -y zsh starship zsh-completions
chsh -s zsh
pkg install -y bat eza fd fzf htop jq yazi ripgrep sd tealdeer tree unrar unzip

mkdir -p "$HOME/.termux"
ln -sf "$host_dir/colors.properties" "$HOME/.termux/colors.properties"

"$host_dir/../kinoite/06-chezmoi.sh"

curl -L \
  --url https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFontMono-Regular.ttf \
  -o "$HOME/.termux/font.ttf"

termux-setup-storage

ln -sf "$HOME/storage/downloads" "$HOME/Downloads"
ln -sf "$HOME/storage/pictures" "$HOME/Pictures"
ln -sf "$HOME/storage/music" "$HOME/Music"

exit 0
