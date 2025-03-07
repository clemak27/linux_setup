#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$HOME/.local/state/syncthing"
mkdir -p "$config_dir/containers/systemd"
cp "$module_dir/syncthing.container" "$config_dir/containers/systemd/syncthing.container"

systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger
