#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$config_dir/containers/systemd"
cp "$module_dir/syncthing.container" "$config_dir/containers/systemd/syncthing.container"

systemctl --user daemon-reload
systemctl --user start syncthing
loginctl enable-linger
