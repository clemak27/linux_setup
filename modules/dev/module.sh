#!/bin/bash

set -eo pipefail

bin_dir="$HOME/.local/bin"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p "$bin_dir"
rm -rf "$HOME/.npmrc"
ln -sf "$module_dir/npmrc" "$HOME/.npmrc"
mkdir -p "$HOME/.gradle"
rm -rf "$HOME/.gradle/gradle.properties"
ln -sf "$module_dir/gradle.properties" "$HOME/.gradle/gradle.properties"
ln -sf "$module_dir/editorconfig.ini" "$HOME/.editorconfig"
