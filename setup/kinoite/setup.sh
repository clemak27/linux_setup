#!/bin/bash

set -eo pipefail

sudo -v

## base

if ! command -v zsh &> /dev/null; then
  rpm-ostree install --idempotent --apply-live distrobox gcc-c++ vim wl-clipboard zsh
  sudo usermod -s /usr/bin/zsh clemens
fi

sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/fedora-cisco-openh264.repo \
  /etc/yum.repos.d/google-chrome.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
  /etc/yum.repos.d/rpmfusion-nonfree-steam.repo

if [ "$HOSTNAME" = "newton" ]; then
  # shit gpu
  rpm-ostree install \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
  rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
  rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
fi

## applications

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub
# flatpak list --columns=application,origin | grep fedora | grep -v "org.fedoraproject" | awk '{ print $1 }'
flatpak uninstall -y \
  org.kde.kmahjongg \
  org.kde.kmines \
  org.kde.kolourpaint \
  org.kde.krdc \
  org.kde.skanpage
flatpak install -y --reinstall flathub \
  org.kde.elisa \
  org.kde.gwenview \
  org.kde.kcalc \
  org.kde.okular
flatpak uninstall -y --unused
flatpak remote-delete fedora

## podman

rpm-ostree install --idempotent podman-docker podman-compose
sudo mkdir -p /etc/containers
sudo touch /etc/containers/nodocker
systemctl --user enable podman.socket

## firefox

# disable default FF
# https://github.com/fedora-silverblue/silverblue-docs/blob/master/modules/ROOT/pages/tips-and-tricks.adoc#hiding-the-default-browser-firefox
if [ -f "/usr/share/applications/org.mozilla.firefox.desktop" ]; then
  sudo mkdir -p /usr/local/share/applications/
  sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
  sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
  sudo update-desktop-database /usr/local/share/applications/
fi

## install flatpak
flatpak install -y flathub \
  org.freedesktop.Platform.ffmpeg-full//24.08 \
  org.mozilla.firefox
flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox

## kde

rpm-ostree install --idempotent ksshaskpass kontact
flatpak install -y flathub \
  com.calibre_ebook.calibre \
  com.obsproject.Studio \
  hu.irl.cameractrls \
  org.gimp.GIMP \
  org.gimp.GIMP.HEIC \
  org.gimp.GIMP.Plugin.GMic//3 \
  org.gtk.Gtk3theme.adw-gtk3 \
  org.gtk.Gtk3theme.adw-gtk3-dark \
  org.kde.haruna \
  org.kde.kid3 \
  org.libreoffice.LibreOffice \
  org.signal.Signal
flatpak override --user --filesystem=xdg-config/gtk-3.0 --filesystem=xdg-config/gtk-4.0

feishin_version=0.13.0

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
curl -L --url https://github.com/jeffvli/feishin/releases/download/v${feishin_version}/Feishin-${feishin_version}-linux-x86_64.AppImage -o "$HOME/.local/bin/feishin"
chmod +x "$HOME/.local/bin/feishin"
curl -L --url https://raw.githubusercontent.com/jeffvli/feishin/refs/heads/development/assets/icons/128x128.png -o "$HOME/.local/share/applications/feishin.png"
echo -e "[Desktop Entry]\nName=Feishin\nExec=$HOME/.local/bin/feishin\nType=Application\nCategories=Multimedia\nIcon=$HOME/.local/share/applications/feishin.png" > "$HOME/.local/share/applications/feishin.desktop"

## wezterm

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
Exec=flatpak run org.wezfurlong.wezterm start --always-new-process --class=io.neovim.nvim zsh -c 'source ~/.zshrc && nvim %F'
Type=Application
Categories=Development;
Terminal=false
EOF

## openrgb

if [ "$HOSTNAME" = "maxwell" ]; then
  mkdir -p "$HOME/.local/share/applications"
  flatpak install -y flathub org.openrgb.OpenRGB
  curl -LO "https://openrgb.org/releases/release_0.9/60-openrgb.rules"
  sudo mv 60-openrgb.rules /etc/udev/rules.d/
  sudo restorecon /etc/udev/rules.d/60-openrgb.rules
  sudo udevadm control --reload-rules
  sudo udevadm trigger
fi

## gaming

rpm-ostree install --idempotent steam-devices
flatpak install -y flathub \
  com.valvesoftware.Steam \
  com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
  dev.vencord.Vesktop \
  net.lutris.Lutris \
  net.retrodeck.retrodeck \
  org.freedesktop.Platform.VulkanLayer.MangoHud//24.08 \
  org.freedesktop.Platform.VulkanLayer.gamescope//24.08 \
  org.freedesktop.Platform.VulkanLayer.MangoHud//23.08 \
  org.freedesktop.Platform.VulkanLayer.gamescope//23.08 \
  org.freedesktop.Platform.ffmpeg-full//24.08
flatpak --user override --filesystem=~/Games com.valvesoftware.Steam
flatpak --user override --filesystem=~/Games net.retrodeck.retrodeck
flatpak --user override --filesystem=~/Games net.lutris.Lutris
flatpak --user override --filesystem=~/Downloads net.lutris.Lutris
flatpak --user override --nofilesystem=home net.lutris.Lutris
flatpak --user override --nofilesystem=host net.lutris.Lutris
curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules
sudo mv 60-steam-input.rules /etc/udev/rules.d/
curl -LO https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules
sudo mv 60-steam-vr.rules /etc/udev/rules.d/

## chezmoi

curl -fsLS get.chezmoi.io > chmz
chmod u+x chmz
./chmz -b "$HOME/.local/bin"
rm -f chmz
mkdir -p "$HOME/.config/chezmoi"
printf "sourceDir: %s/Projects/linux_setup" "$HOME" > "$HOME/.config/chezmoi/chezmoi.yaml"
"$HOME/.local/bin/chezmoi" apply --force

## mise

curl https://mise.run | sh
"$HOME/.local/bin/mise" trust
"$HOME/.local/bin/mise" install -y

## syncthing

mkdir -p "$HOME/.local/state/syncthing"
systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger

systemctl reboot
