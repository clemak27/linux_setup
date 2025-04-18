#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$config_dir/bat" "$config_dir/yt-dlp"
ln -sf "$module_dir/bat.config" "$config_dir/bat/config"
echo '-o ~/Downloads/youtube/%(title)s.%(ext)s' > "$config_dir/yt-dlp/config"
mkdir -p "$bin_dir"
mkdir -p "$config_dir/tealdeer"
ln -sf "$module_dir/tealdeer.toml" "$config_dir/tealdeer/config.toml"
ln -sf "$module_dir/cdp" "$bin_dir/cdp"
