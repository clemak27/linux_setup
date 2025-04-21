#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# create box with all deps
distrobox assemble create --file "$module_dir/box.ini" --name main --replace
distrobox enter main -- rm -rf "$HOME/.cache/paru" && git clone https://aur.archlinux.org/paru.git "$HOME/.cache/paru"
distrobox enter main -- zsh -c "cd $HOME/.cache/paru && makepkg -si --noconfirm"
distrobox enter main -- paru -Syu --noconfirm viddy kubecolor
distrobox enter main -- rm -rf "$HOME/.cache/paru"
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/v3.0.0 -o /tmp/nix.sh
chmod +x /tmp/nix.sh
distrobox enter main -- zsh -c "/tmp/nix.sh install linux --no-confirm --init none"
distrobox enter main -- zsh -c "sudo chown -R clemens /nix"
rm /tmp/nix.sh

# fp
flatpak install -y flathub org.wezfurlong.wezterm
printf 'flatpak run --env=WEZTERM_PANE=$WEZTERM_PANE --env=WEZTERM_UNIX_SOCKET=$WEZTERM_UNIX_SOCKET org.wezfurlong.wezterm "$@"' > "$bin_dir/wezterm"
chmod +x "$bin_dir/wezterm"

# setup additional completions
cat /usr/share/zsh/site-functions/_flatpak > _flatpak
podman cp _flatpak main:/usr/share/zsh/site-functions/_flatpak
rm -f _flatpak

cat << EOF > "$HOME/.local/share/applications/io.neovim.nvim.desktop"
[Desktop Entry]
Name=nvim
Comment=neovim
Keywords=shell;prompt;command;commandline;cmd;editor;
Icon=io.neovim.nvim
StartupWMClass=io.neovim.nvim
Exec=flatpak run org.wezfurlong.wezterm start --always-new-process --class=io.neovim.nvim distrobox-enter main -- nvim %F
Type=Application
Categories=Development;
Terminal=false
EOF
