#!/bin/zsh

__init_nix() {
  mkdir -p $HOME/.nix

  cat <<EOF >/tmp/nix-init.ini
[nix]
image=quay.io/toolbx/arch-toolbox:latest
pull=true
init=false
start_now=true
entry=false
volume="/home/linuxbrew/:/home/linuxbrew/"
volume="$HOME/.nix/:/nix"
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/podman;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/flatpak;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/buildah;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/rpm-ostree;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/systemctl;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/xdg-open;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/ksshaskpass;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/wl-copy;
init_hooks=sudo ln -sf /usr/bin/distrobox-host-exec /usr/bin/wl-paste;
EOF

  cat <<EOF >/tmp/nix.hook
[Trigger]
Operation = Upgrade
Type = Package
Target = *

[Action]
Description = nix profile upgrade hook
When = PostTransaction
Exec = /nix/var/nix/profiles/default/bin/nix profile upgrade --all
EOF

  /usr/bin/distrobox assemble create --file /tmp/nix-init.ini --name nix --replace
  # renovate: datasource=github-tags depName=DeterminateSystems/nix-installer versioning=loose
  nixinstaller_version=3.6.1
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/v$nixinstaller_version -o /tmp/nix.sh
  chmod +x /tmp/nix.sh
  /usr/bin/distrobox enter nix -- zsh -c "/tmp/nix.sh install linux --no-confirm --init none"
  /usr/bin/distrobox enter nix -- zsh -c "sudo chown -R 1000:1000 /nix"
  /usr/bin/distrobox enter nix -- zsh -c '/nix/var/nix/profiles/default/bin/nix profile install nixpkgs#nixd nixpkgs#nixfmt-rfc-style nixpkgs#direnv'
  podman cp /tmp/nix.hook nix:/usr/share/libalpm/hooks/99_nix_profile.hook
  rm -f /tmp/nix.sh /tmp/nix-init.ini /tmp/nix.hook
}

if [ -z "${CONTAINER_ID}" ]; then
  nix() {
    /usr/bin/distrobox-enter nix -- /nix/var/nix/profiles/default/bin/nix "$@"
  }

  nixd() {
    if [ -f "$PWD/flake.nix" ]; then
      /usr/bin/distrobox-enter nix -- /nix/var/nix/profiles/default/bin/nix develop --command zsh
    else
      /usr/bin/distrobox-enter nix -- zsh
    fi
  }
fi
