#!/bin/bash

set -eo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

/usr/bin/podman build . -t archnix:latest -f "$script_dir/Containerfile"
/usr/bin/distrobox create --image archnix:latest --name main --no-entry

# /usr/bin/distrobox enter main -- zsh -c 'sudo chown -R $USER /nix'
/usr/bin/distrobox enter main -- zsh -c 'PATH="/nix/var/nix/profiles/default/bin:$PATH" nix profile install nixpkgs#nixd nixpkgs#nixfmt-rfc-style nixpkgs#direnv'
