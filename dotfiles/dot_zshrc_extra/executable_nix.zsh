#!/bin/zsh

__init_nix() {
  if /usr/bin/distrobox-list | grep "\snix\s"; then
    return
  fi

  cat <<EOF >/tmp/nix-init.ini
[nix]
image=quay.io/toolbx/arch-toolbox:latest
pull=true
init=false
start_now=true
entry=false
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

  /usr/bin/distrobox assemble create --file /tmp/nix-init.ini --name nix --replace
  # renovate: datasource=github-tags depName=DeterminateSystems/nix-installer versioning=loose
  nixinstaller_version=3.6.1
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix/tag/v$nixinstaller_version -o /tmp/nix.sh
  chmod +x /tmp/nix.sh
  /usr/bin/distrobox enter nix -- zsh -c "/tmp/nix.sh install linux --no-confirm --init none"
  /usr/bin/distrobox enter nix -- zsh -c "sudo chown -R clemens /nix"
  rm -f /tmp/nix.sh /tmp/nix-init.ini
  /usr/bin/distrobox enter nix -- zsh -c 'PATH="/nix/var/nix/profiles/default/bin:$PATH" nix profile install nixpkgs#nixd nixpkgs#nixfmt-rfc-style'
  curl -fLO https://raw.githubusercontent.com/NixOS/nix/refs/heads/master/misc/zsh/completion.zsh
  mv completion.zsh ~/.oh-my-zsh/custom/completions/_nix
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
