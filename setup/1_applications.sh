#!/bin/bash

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.mozilla.firefox org.keepassxc.KeePassXC org.kde.kid3 io.mpv.Mpv

# symlink dotfiles
mkdir -p /home/clemens/.config/alacritty
ln -sf /home/clemens/Projects/linux_setup/dotfiles/alacritty.yml /home/clemens/.config/alacritty/alacritty.yml


# install fonts
curl -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
mkdir -p /home/clemens/.local/share/fonts
unzip FiraCode.zip -d /home/clemens/.local/share/fonts

# workaround for alacritty WL issue
cp /usr/share/applications/Alacritty.desktop ~/.local/share/applications/
sed -i 's/^Exec=alacritty$/Exec=env -u WAYLAND_DISPLAY alacritty/g' ~/.local/share/applications/Alacritty.desktop


