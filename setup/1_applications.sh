#!/bin/bash

# flatpaks
flatpak install -y flathub \
  com.bitwarden.desktop \
  com.discordapp.Discord \
  com.github.GradienceTeam.Gradience \
  com.github.tchx84.Flatseal \
  com.valvesoftware.Steam \
  io.gdevs.GDLauncher \
  io.github.celluloid_player.Celluloid \
  io.mpv.Mpv \
  org.freedesktop.Platform.VulkanLayer.MangoHud \
  org.freedesktop.Platform.ffmpeg-full \
  org.gimp.GIMP \
  org.kde.kid3 \
  org.libreoffice.LibreOffice \
  org.mozilla.Thunderbird \
  org.mozilla.firefox \
  org.openrgb.OpenRGB \
  org.pipewire.Helvum \
  org.signal.Signal \
  org.zdoom.GZDoom
flatpak install -y flathub \
  com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
  com.valvesoftware.Steam.Utility.gamescope
flatpak install -y fedora \
  org.gnome.Extensions

# firefox should use wayland
flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox

# symlink host dotfiles
mkdir -p /home/clemens/.config/wezterm
ln -sf /home/clemens/Projects/linux_setup/dotfiles/wezterm.lua /home/clemens/.config/wezterm/wezterm.lua
ln -sf /home/clemens/Projects/linux_setup/dotfiles/bashrc /home/clemens/.bashrc
ln -sf /home/clemens/Projects/linux_setup/dotfiles/vimrc /home/clemens/.vimrc

# install user gnome shell extensions
mkdir -p ~/.local/share/gnome-shell/extensions
curl -L -o /tmp/unite-shell-v59.zip --url https://github.com/hardpixel/unite-shell/releases/download/v59/unite-shell-v59.zip
unzip /tmp/unite-shell-v59.zip -d ~/.local/share/gnome-shell/extensions
curl -L -o /tmp/blur-my-shell@aunetx.zip --url https://github.com/aunetx/blur-my-shell/releases/download/v28/blur-my-shell@aunetx.zip
unzip /tmp/blur-my-shell@aunetx.zip -d ~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx
curl -L -o /tmp/userThemes.zip --url https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v49.shell-extension.zip
unzip /tmp/userThemes.zip -d ~/.local/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com

# install icon theme
wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh

# install adw-gtk3 theme
mkdir -p /home/clemens/.themes
curl -L -o /tmp/adw-gtk3.tar.xz --url https://github.com/lassekongo83/adw-gtk3/releases/download/v3.6/adw-gtk3v3-6.tar.xz
tar xf /tmp/adw-gtk3.tar.xz --directory /home/clemens/.themes
flatpak install -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

# enable customization
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
sudo flatpak override --filesystem=xdg-config/gtk-3.0
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --filesystem=~/.icons

# install fonts
mkdir -p /home/clemens/.local/share/fonts
curl -L -o /tmp/FiraCode.zip --url https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
unzip /tmp/FiraCode.zip -d /home/clemens/.local/share/fonts

# openrgb
sudo cp 60-openrgb.rules /etc/udev/rules.d/60-openrgb.rules
cp org.openrgb.OpenRGB.desktop ~/.local/share/applications/

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

# custom shortcuts
dconf write /org/gnome/settings-daemon/plugins/media-keys/home "['<Super>e']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/www "['<Super>b']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>k'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'flatpak run com.bitwarden.desktop'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'bitwarden'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Super>Return'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command "'flatpak run org.wezfurlong.wezterm'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name "'wezterm'"

# install sonixd -> https://github.com/jeffvli/sonixd/issues/306
curl -O -L https://github.com/jeffvli/sonixd/releases/download/v0.15.3/Sonixd-0.15.3-linux-x64.tar.xz
mkdir -p /var/home/clemens/.var/app/not.a.flatpak.sonixd/app
mkdir -p /var/home/clemens/.var/app/not.a.flatpak.sonixd/config
tar -xf Sonixd-0.15.3-linux-x64.tar.xz --directory /var/home/clemens/.var/app/not.a.flatpak.sonixd/app
mv /var/home/clemens/.var/app/not.a.flatpak.sonixd/Sonixd-0.15.3-linux-x64 /var/home/clemens/.var/app/not.a.flatpak.sonixd/app
rm Sonixd-0.15.3-linux-x64.tar.xz
ln -sf /home/clemens/.var/app/not.a.flatpak.sonixd/config /home/clemens/.config/Sonixd
cat << 'EOF' > /home/clemens/.local/share/applications/Sonixd.desktop
[Desktop Entry]
Name=Sonixd
Exec=/var/home/clemens/.var/app/not.a.flatpak.sonixd/app/sonixd
Terminal=false
Type=Application
Icon=/var/home/clemens/.var/app/not.a.flatpak.sonixd/app/resources/assets/icon.png
Categories=Audio;AudioVideo
EOF
