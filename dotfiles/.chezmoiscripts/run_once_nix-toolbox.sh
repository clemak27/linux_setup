#!/bin/bash

set -eo pipefail

if distrobox-list | grep nix-toolbox > /dev/null; then
  exit 0
fi

db_run="distrobox-enter nix-toolbox -- bash -c"

distrobox create --pull --no-entry \
  --image ghcr.io/thrix/nix-toolbox:44 \
  --name nix-toolbox
$db_run "source /etc/profile.d/nix.sh && exit 0"

$db_run "sudo ln -sf /usr/sbin/distrobox-host-exec /usr/bin/qemu-aarch64-static"
$db_run "sudo ln -sf /usr/sbin/distrobox-host-exec /usr/libexec/openssh/gnome-ssh-askpass"

$db_run "echo 'extra-platforms = aarch64-linux' | sudo tee -a /etc/nix/nix.conf"
$db_run "echo 'extra-sandbox-paths = /usr/bin/qemu-aarch64-static' | sudo tee -a /etc/nix/nix.conf"
$db_run "echo 'filter-syscalls = false' | sudo tee -a /etc/nix/nix.conf"

$db_run "$HOME/.nix-profile/bin/nix profile add nixpkgs#nixd nixpkgs#nixpkgs-fmt nixpkgs#nixos-rebuild"
$db_run "distrobox-export --bin ~/.nix-profile/bin/nix"
$db_run "distrobox-export --bin ~/.nix-profile/bin/nixd"
$db_run "distrobox-export --bin ~/.nix-profile/bin/nixpkgs-fmt"
