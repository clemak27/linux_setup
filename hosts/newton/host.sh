#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"

rpm-ostree install --idempotent vim make zsh distrobox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# reboot is needed so the base packages are installed
if ! command -v distrobox > /dev/null; then systemctl reboot; fi
sudo usermod -s /usr/bin/zsh clemens
sudo sed -i 's/enabled=1/enabled=0/' \
  /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
  /etc/yum.repos.d/google-chrome.repo

"$host_dir/../../modules/dev/module.sh"
"$host_dir/../../modules/firefox/module.sh"
"$host_dir/../../modules/gaming/module.sh"
"$host_dir/../../modules/git/module.sh"
"$host_dir/../../modules/kde/module.sh"
"$host_dir/../../modules/nvim/module.sh"
"$host_dir/../../modules/podman/module.sh"
"$host_dir/../../modules/syncthing/module.sh"
"$host_dir/../../modules/tools/module.sh"
"$host_dir/../../modules/wezterm/module.sh"
"$host_dir/../../modules/zsh/module.sh"

# git
pubKey=$(cat "$HOME/.ssh/id_ed25519.pub")
git config --global user.email "clemak27@mailbox.org"
git config --global user.name "clemak27"
git config --global user.signingkey "$pubKey"
echo "clemak27@mailbox.org $pubKey" > "$HOME/.ssh/allowed_signers"

# theme
cp "$host_dir/gtk.css" "$HOME/.config/gtk-3.0/gtk.css"
cp "$host_dir/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"

# wg
rpm-ostree install --idempotent wireguard-tools

# shit gpu
rpm-ostree install --idempotent --apply-live https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm
rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
echo "#!/bin/sh" > prime-run
echo >> prime-run
echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> prime-run
echo "export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0" >> prime-run
echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> prime-run
echo "export __VK_LAYER_NV_optimus=NVIDIA_only" >> prime-run
echo "export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json" >> prime-run
echo 'exec -a "$0" "$@"' >> prime-run
chmod +x prime-run
sudo mv prime-run /usr/local/bin
sudo flatpak override --env=__NV_PRIME_RENDER_OFFLOAD=1 net.retrodeck.retrodeck
sudo flatpak override --env=__NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 net.retrodeck.retrodeck
sudo flatpak override --env=__GLX_VENDOR_LIBRARY_NAME=nvidia net.retrodeck.retrodeck
sudo flatpak override --env=__VK_LAYER_NV_optimus=NVIDIA_only net.retrodeck.retrodeck

sudo flatpak override --env=__NV_PRIME_RENDER_OFFLOAD=1 com.valvesoftware.Steam
sudo flatpak override --env=__NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 com.valvesoftware.Steam
sudo flatpak override --env=__GLX_VENDOR_LIBRARY_NAME=nvidia com.valvesoftware.Steam
sudo flatpak override --env=__VK_LAYER_NV_optimus=NVIDIA_only com.valvesoftware.Steam

# hw
# kwriteconfig6 "$config_dir/kxkbrc" --group "Layout" --key "LayoutList" "us"
# kwriteconfig6 "$config_dir/kxkbrc" --group "Layout" --key "Use" "true"
# kwriteconfig6 "$config_dir/kxkbrc" --group "Layout" --key "VariantList" "altgr-intl"

# 192.168.178.100:/media /home/clemens/nfs/media nfs x-systemd.automount,_netdev,x-systemd.idle-timeout=60,noauto 0 0

systemctl reboot
