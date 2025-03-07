#!/bin/bash

set -eo pipefail

config_dir="$HOME/.config"
module_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

[[ -d $HOME/.oh-my-zsh ]] || (curl -fsSL -o omz.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && chmod +x omz.sh && ./omz.sh --unattended --skip-keepzshrc && rm -rf omz.sh)
[[ -d $HOME/.oh-my-zsh/custom/plugins/gradle-completion ]] || git clone https://github.com/gradle/gradle-completion "$HOME/.oh-my-zsh/custom/plugins/gradle-completion"
ln -sf "$module_dir/zshrc" "$HOME/.zshrc"
ln -sf "$module_dir/starship.toml" "$config_dir/starship.toml"
