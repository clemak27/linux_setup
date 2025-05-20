#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

if [[ -z "$TERMUX_VERSION" ]]; then
  echo "not running on termux"
  exit 1
fi

# termux-change-repo
# termux-setup-storage
# pkg install -y git
# mkdir -p .config ~/Projects
# cd Projects
# git clone https://github.com/clemak27/linux_setup
# cd linux_setup
# ./setup/termux/setup.sh

echo "symlink storage"

rm -rf "$HOME/Downloads"
ln -sf "$HOME/storage/downloads" "$HOME/Downloads"
rm -rf "$HOME/Pictures"
ln -sf "$HOME/storage/pictures" "$HOME/Pictures"
rm -rf "$HOME/Music"
ln -sf "$HOME/storage/music" "$HOME/Music"

echo "install packages"

pkg install -y zsh starship zsh-completions \
  git git-delta lazygit \
  bat chezmoi eza fd fzf htop jq yazi ripgrep sd tealdeer tree unrar unzip
chsh -s zsh

echo "setup colors"

mkdir -p "$HOME/.termux"
ln -sf "$host_dir/colors.properties" "$HOME/.termux/colors.properties"

echo "download font"

curl -L \
  --url https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/JetBrainsMonoNLNerdFontMono-Regular.ttf \
  -o "$HOME/.termux/font.ttf"

echo "symlink dotfiles"
# this is easier than maintaining a list in .chezmoiignore, since termux needs just a few files

ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_zshrc" "$HOME/.zshrc"
ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/bat"
ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/bat/config" "$HOME/.config/bat/config"

mkdir -p "$HOME/.config/git"
cat "$HOME/Projects/linux_setup/dotfiles/dot_config/git/config.tmpl" | chezmoi execute-template > "$HOME/.config/git/config"

mkdir -p "$HOME/.config/lazygit"
cp --remove-destination "$HOME/Projects/linux_setup/dotfiles/dot_config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
printf "gui:\n  enlargedSideViewLocation: top" >> "$HOME/.config/lazygit/config.yml"

mkdir -p "$HOME/.config/tealdeer"
ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/tealdeer/config.toml" "$HOME/.config/tealdeer/config.toml"

mkdir -p "$HOME/.config/yt-dlp"
ln -sf "$HOME/Projects/linux_setup/dotfiles/dot_config/yt-dlp/config" "$HOME/.config/yt-dlp/config"

mkdir -p "$HOME/.local/bin"
cp --remove-destination "$HOME/Projects/linux_setup/dotfiles/dot_local/bin/executable_gcmld" "$HOME/.local/bin/gcmld"
chmod u+x "$HOME/.local/bin/gcmld"
