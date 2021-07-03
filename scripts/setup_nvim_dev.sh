#!/bin/sh

install_dir="$HOME/.local/bin/nvim"
lsp_dir="$install_dir/lsp"
dap_dir="$install_dir/dap"
current_dir=$(pwd)

# create folders
mkdir -p "$lsp_dir"
mkdir -p "$dap_dir"

# --------------------------- lsp ------------------------------

# --------------------------- linter ---------------------------
npm i -g markdownlint-cli
npm i -g eslint
go install github.com/mgechev/revive@latest
paru -S shellcheck-bin

# --------------------------- dap ------------------------------

# nodejs
cd "$dap_dir" || exit
git clone https://github.com/microsoft/vscode-node-debug2.git
cd vscode-node-debug2 || exit
npm install
./node_modules/gulp/bin/gulp.js build

cd "$current_dir" || exit
