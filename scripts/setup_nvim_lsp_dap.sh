#!/bin/sh

install_dir="$HOME/.local/bin"
lsp_dir="$install_dir/lsp"
dap_dir="$install_dir/dap"
current_dir=$(pwd)

# create folders
mkdir -p "$lsp_dir"
mkdir -p "$dap_dir"

# nodejs
cd "$dap_dir" || exit
git clone https://github.com/microsoft/vscode-node-debug2.git
cd vscode-node-debug2 || exit
npm install
./node_modules/gulp/bin/gulp.js build

cd "$current_dir" || exit
