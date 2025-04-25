#!/bin/bash

set -xueo pipefail

init_hooks=$(
  cat << EOF
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/podman;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/flatpak;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/buildah;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/rpm-ostree;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/systemctl;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/xdg-open;
  sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/ksshaskpass;
  sudo usermod -s /usr/bin/zsh clemens;
EOF
)

/usr/bin/distrobox-create --yes \
  --name main \
  --image quay.io/toolbx/arch-toolbox:latest \
  --pull \
  --no-entry \
  --init-hooks "$init_hooks" \
  --additional-packages "wl-clipboard make curl git git-delta lazygit github-cli cyme breeze" \
  --additional-packages "go delve nodejs-lts-jod gradle jdk21-openjdk direnv kotlin" \
  --additional-packages "krew kubectl kubectx helm kustomize stern" \
  --additional-packages "bat curl eza fd fzf hurl htop jq pgcli yazi ripgrep sd tealdeer tree unrar unzip go-yq yt-dlp" \
  --additional-packages "android-tools scrcpy" \
  --additional-packages "nodejs-lts-jod npm gcc deno rust python neovim" \
  --additional-packages "zsh starship zsh-completions zsh-syntax-highlighting"

/usr/bin/distrobox enter main -- rm -rf "$HOME/.cache/paru" && git clone https://aur.archlinux.org/paru.git "$HOME/.cache/paru"
/usr/bin/distrobox enter main -- zsh -c "cd $HOME/.cache/paru && makepkg -si --noconfirm"
/usr/bin/distrobox enter main -- paru -Syu --noconfirm viddy kubecolor
/usr/bin/distrobox enter main -- rm -rf "$HOME/.cache/paru"
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/v3.0.0 -o /tmp/nix.sh
chmod +x /tmp/nix.sh
/usr/bin/distrobox enter main -- zsh -c "/tmp/nix.sh install linux --no-confirm --init none"
/usr/bin/distrobox enter main -- zsh -c "sudo chown -R clemens /nix"
rm /tmp/nix.sh

# setup additional completions
cat /usr/share/zsh/site-functions/_flatpak > _flatpak
podman cp _flatpak main:/usr/share/zsh/site-functions/_flatpak
rm -f _flatpak
