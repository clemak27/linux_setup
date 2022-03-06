#!/bin/bash

# create a container first
# toolbox create sublime-music
# toolbox enter sublime-music

install_dir=$HOME/.toolbox/sublime-music
bin_location=$HOME/.local/bin/sublime-music
custom_bin_location=$HOME/.local/bin/sublime-music-dark

sudo dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf install -y "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

sudo dnf install -y \
cairo \
cairo-gobject-devel \
gobject-introspection-devel \
gtk3-devel \
mpv-libs-devel \
pip \
python3-cairo-devel \
rust

python3 -m pip install --user pipx
python3 -m pipx ensurepath

pipx install sublime-music[keyring,chromecast,server]

echo "GTK_THEME=Adwaita:dark $bin_location" > "$custom_bin_location"
chmod +x "$custom_bin_location"

# https://gitlab.com/sublime-music/sublime-music/-/issues/304
mkdir -p ~/.local/share/icons
wget https://gitlab.com/sublime-music/sublime-music/-/raw/master/logo/icon.svg\?inline\=false -O ~/.local/share/icons/sublime-music.svg

{
echo "[Desktop Entry]"
echo "Version=1.1"
echo "Type=Application"
echo "Name=Sublime Music"
echo "Name[es]=Música Sublime"
echo "GenericName=Music Player"
echo "Comment=Native Subsonic client for Linux"
echo "Exec=toolbox run -c sublime-music $custom_bin_location"
echo "Icon=sublime-music"
echo "Terminal=false"
echo "Categories=AudioVideo;Audio;Music;"
} > ~/.local/share/applications/sublime-music.desktop
