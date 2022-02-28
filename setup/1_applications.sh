#!/bin/bash

# flatpaks
flatpak install -y flathub \
  com.discordapp.Discord \
  com.github.tchx84.Flatseal \
  com.valvesoftware.Steam \
  io.gdevs.GDLauncher \
  io.mpv.Mpv \
  org.freedesktop.Platform.ffmpeg-full \
  org.gimp.GIMP \
  org.kde.kid3 \
  org.keepassxc.KeePassXC \
  org.libreoffice.LibreOffice \
  org.mozilla.firefox \
  org.openrgb.OpenRGB \
  org.pipewire.Helvum \
  org.signal.Signal \
  org.zdoom.GZDoom
flatpak install -y flathub \
  com.valvesoftware.Steam.CompatibilityTool.Proton-GE
flatpak install -y fedora \
  org.gnome.Extensions

# symlink dotfiles
mkdir -p /home/clemens/.config/alacritty
ln -sf /home/clemens/Projects/linux_setup/dotfiles/alacritty.yml /home/clemens/.config/alacritty/alacritty.yml
ln -sf /home/clemens/Projects/linux_setup/dotfiles/bashrc /home/clemens/.bashrc

# install icon theme
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

# install fonts
mkdir -p /home/clemens/.local/share/fonts
curl -L -o /tmp/FiraCode.zip --url https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip /tmp/FiraCode.zip -d /home/clemens/.local/share/fonts

# install user gnome shell extensions
mkdir -p ~/.local/share/gnome-shell/extensions
curl -L -o /tmp/unite-shell-v59.zip --url https://github.com/hardpixel/unite-shell/releases/download/v59/unite-shell-v59.zip
unzip /tmp/unite-shell-v59.zip -d ~/.local/share/gnome-shell/extensions
curl -L -o /tmp/blur-my-shell@aunetx.zip --url https://github.com/aunetx/blur-my-shell/releases/download/v28/blur-my-shell@aunetx.zip
unzip /tmp/blur-my-shell@aunetx.zip -d ~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx

# workaround for alacritty WL issue
cp /usr/share/applications/Alacritty.desktop ~/.local/share/applications/
sed -i 's/^Exec=alacritty$/Exec=env -u WAYLAND_DISPLAY alacritty/g' ~/.local/share/applications/Alacritty.desktop

# openrgb rules
sudo cp 60-openrgb.rules /etc/udev/rules.d/60-openrgb.rules

# gnome shortcuts
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"
