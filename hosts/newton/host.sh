#!/bin/bash

set -eo pipefail

host_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rpm-ostree install --idempotent vim make zsh distrobox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
rpm-ostree install --idempotent https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm
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

# shit gpu
rpm-ostree install --idempotent xorg-x11-drv-nvidia akmod-nvidia
rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init
cat << EOF > prime-run
#!/bin/sh

export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
exec -a "$$0" "$$@"
EOF
chmod +x prime-run
sudo mv prime-run /usr/local/bin

systemctl reboot
