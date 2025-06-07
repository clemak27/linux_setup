#!/bin/bash

set -eo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

/usr/bin/podman build . -t archnix:latest -f "$script_dir/Containerfile"
/usr/bin/distrobox rm main --force
/usr/bin/distrobox create --image archnix:latest --name main --no-entry

post_setup_commands=(
  "paru -Syu --noconfirm kubecolor"
  "sudo chown -R $USER /nix"
  "/nix/var/nix/profiles/default/bin/nix profile install nixpkgs#nixd nixpkgs#nixfmt-rfc-style nixpkgs#direnv"
)

for command in "${post_setup_commands[@]}"; do
  /usr/bin/distrobox enter main -- zsh -c "$command"
done
