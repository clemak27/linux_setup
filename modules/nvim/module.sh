#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

rm -rf "$config_dir/nvim"
mkdir -p "$config_dir/nvim"
ln -sf "$module_dir/init.lua" "$config_dir/nvim/init.lua"
ln -sf "$module_dir/lua" "$config_dir/nvim/lua"
mkdir -p "$config_dir/yamlfmt"
ln -sf "$module_dir/yamlfmt.yaml" "$config_dir/yamlfmt/.yamlfmt"
ln -sf "$module_dir/markdownlintrc.json" "$HOME/.markdownlintrc"
ln -sf "$module_dir/snippets" "$config_dir/nvim/snippets"
ln -sf "$module_dir/jdtls-fmt.xml" "$HOME/.jdtls-fmt.xml"
