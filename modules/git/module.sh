#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$bin_dir"
ln -sf "$module_dir/lg" "$bin_dir/lg"
ln -sf "$module_dir/gcmld" "$bin_dir/gcmld"

mkdir -p "$config_dir/git"
cp "$module_dir/config" "$config_dir/git/config"

mkdir -p "$config_dir/lazygit"
ln -sf "$module_dir/lgconfig" "$config_dir/lazygit/config.yml"
