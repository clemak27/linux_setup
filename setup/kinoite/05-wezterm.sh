#!/bin/bash

set -xueo pipefail

flatpak install -y flathub org.wezfurlong.wezterm
printf 'flatpak run --env=WEZTERM_PANE=$WEZTERM_PANE --env=WEZTERM_UNIX_SOCKET=$WEZTERM_UNIX_SOCKET org.wezfurlong.wezterm "$@"' > "$HOME/.local/bin/wezterm"
chmod +x "$HOME/.local/bin/wezterm"

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
