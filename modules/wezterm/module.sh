#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

distrobox assemble create --file "$module_dir/box.ini" --name wezterm --replace
distrobox enter wezterm -- distrobox-export --app wezterm
distrobox enter wezterm -- rm -rf "$HOME/.cache/paru" && git clone https://aur.archlinux.org/paru.git "$HOME/.cache/paru"
distrobox enter wezterm -- zsh -c "cd $HOME/.cache/paru && makepkg -si --noconfirm"
distrobox enter wezterm -- paru -Syu --noconfirm viddy kubecolor
distrobox enter wezterm -- rm -rf "$HOME/.cache/paru"
mkdir -p "$config_dir/wezterm"
ln -sf "$module_dir/wezterm.lua" "$config_dir/wezterm/wezterm.lua"
ln -sf "$module_dir/bindings.lua" "$config_dir/wezterm/bindings.lua"
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak install -y flathub org.wezfurlong.wezterm
# echo 'flatpak run org.wezfurlong.wezterm "$$@"' > "$$HOME/.local/bin/wezterm"
# chmod +x "$$HOME/.local/bin/wezterm"
