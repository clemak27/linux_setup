#!/bin/bash

# paths
install_dir="$HOME/.local/bin/nvim"
lsp_dir="$install_dir/lsp"
dap_dir="$install_dir/dap"
current_dir=$(pwd)

# helper
repo_updated() {
  h1="$(git rev-parse HEAD)"
  h2="$(git rev-parse @\{u\})"

  if [ "$h1" = "$h2" ]
  then
    return 1
  else
    git pull
    npm install
    return 0
  fi

  unset h1
  unset h2
}

update_node_package() {
  pkg_name=$1
  local=$(npm -g list --depth=0 | grep "$pkg_name" | awk -F@ '{ print $2}')
  remote=$(npm v "$pkg_name" version)

  if [ "$local" != "$remote" ]
  then
    npm i -g "$pkg_name"
  else
    echo "[$pkg_name] Already up to date."
  fi

  unset pkg_name
  unset local
  unset remote
}

# create folders
mkdir -p "$lsp_dir"
mkdir -p "$dap_dir"

# --------------------------- update plugins ---------------------

echo "Updating nvim plugins"
nvim -c 'PlugUpgrade | PlugUpdate | qa'

# --------------------------- lsp ------------------------------

echo "Updating LSP server"

sumneko_lua() {
  cd "$lsp_dir" || exit
  latest=$(curl --no-progress-meter -L -I https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep last-modified)
  current=$(cat current_luals.txt)
  if [ "$latest" = "$current" ]
  then
    echo "[sumneko_lua] Already up to date."
  else
    os=$(uname -s | tr "[:upper:]" "[:lower:]")
    case $os in
      linux)
        platform="Linux"
        ;;
      darwin)
        platform="macOS"
        ;;
    esac
    curl -L -o sumneko-lua.vsix "$(curl -s https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_' | cut -d\" -f4)"
    rm -rf sumneko-lua
    unzip sumneko-lua.vsix -d sumneko-lua
    rm sumneko-lua.vsix
    chmod +x sumneko-lua/extension/server/bin/$platform/lua-language-server
    echo "#!/usr/bin/env bash" > sumneko-lua-language-server
    echo "\$(dirname \$0)/sumneko-lua/extension/server/bin/$platform/lua-language-server -E -e LANG=en \$(dirname \$0)/sumneko-lua/extension/server/main.lua \$*" >> sumneko-lua-language-server
    chmod +x sumneko-lua-language-server
    echo "$latest" > current_luals.txt
  fi

}

vuels() {
  update_node_package vls
}

bashls() {
  update_node_package bash-language-server
}

vimls() {
  update_node_package vim-language-server
}

tsserver() {
  # update_node_package typescript
  update_node_package typescript-language-server
}

html_css_json_ls() {
  cd "$lsp_dir" || exit
  latest=$(curl --no-progress-meter -L -I https://update.code.visualstudio.com/latest/linux-x64/stable | grep last-modified)
  current=$(cat current_vscode_ls.txt)

  if [ "$latest" = "$current" ]
  then
    echo "[vscode-html] Already up to date."
    echo "[vscode-css] Already up to date."
    echo "[vscode-json] Already up to date."
  else
    curl -L -o vscode.tar.gz https://update.code.visualstudio.com/latest/linux-x64/stable
    rm -rf vscode
    mkdir vscode
    tar -xzf vscode.tar.gz -C vscode --strip-components 1
    rm vscode.tar.gz

    rm -rf vscode-html
    mkdir vscode-html
    cp -r vscode/resources/app/extensions/node_modules vscode-html
    cp -r vscode/resources/app/extensions/html-language-features vscode-html

    rm -rf vscode-css
    mkdir vscode-css
    cp -r vscode/resources/app/extensions/node_modules vscode-css
    cp -r vscode/resources/app/extensions/css-language-features vscode-css

    rm -rf vscode-json
    mkdir vscode-json
    cp -r vscode/resources/app/extensions/node_modules vscode-json
    cp -r vscode/resources/app/extensions/json-language-features vscode-json

    rm -rf vscode
    echo "$latest" > current_vscode_ls.txt
  fi

}

yamlls() {
  yarn global add yaml-language-server
}

gopls() {
  if [[ $(go install golang.org/x/tools/gopls@latest) ]]; then
    echo "[gopls] Updated."
  else
    echo "[gopls] Already up to date."
  fi
}

jdtls() {
  cd "$lsp_dir" || exit
  if [ -d "jdtls" ]
  then
    latest=$(curl --no-progress-meter https://download.eclipse.org/jdtls/snapshots/latest.txt)
    current=$(cat current_jdtls.txt)
    if [ "$latest" = "$current" ]
    then
      echo "[jdtls] Already up to date."
    else
      curl -O http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
      tar -xzvf jdt-language-server-latest.tar.gz -C ./jdtls
      echo "$latest" > current_jdtls.txt
      rm jdt-language-server-latest.tar.gz
    fi
  else
    curl -O http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
    mkdir -p jdtls
    tar -xzvf jdt-language-server-latest.tar.gz -C ./jdtls
    echo "$latest" > current_jdtls.txt
    rm jdt-language-server-latest.tar.gz
  fi

  unset "$latest"
  unset "$current"
}

sumneko_lua
vuels
bashls
vimls
tsserver
html_css_json_ls
yamlls
gopls
jdtls

# --------------------------- linter ---------------------------

echo "Updating linter"

update_node_package markdownlint-cli
update_node_package eslint

if [[ $(go install github.com/mgechev/revive@latest) ]]; then
  echo "[revive] Updated."
else
  echo "[revive] Already up to date."
fi

paru -S shellcheck-bin

# --------------------------- dap --------------------------------

echo "Updating Debug Adapters"

# nodejs
cd "$dap_dir" || exit
if [ -d "vscode-node-debug2" ]
then
  cd vscode-node-debug2 || exit
  git restore .
  if repo_updated; then ./node_modules/gulp/bin/gulp.js build; else echo "[vscode-node-debug2] Already up to date."; fi
else
  git clone https://github.com/microsoft/vscode-node-debug2.git
  cd vscode-node-debug2 || exit
  npm install
  ./node_modules/gulp/bin/gulp.js build
fi

# golang
if [[ $(go install github.com/go-delve/delve/cmd/dlv@latest) ]]; then
  echo "[dlv] Updated."
else
  echo "[dlv] Already up to date."
fi
cd "$dap_dir" || exit
if [ -d "vscode-go" ]
then
  cd vscode-go || exit
  git restore .
  if repo_updated; then npm run compile; else echo "[vscode-go] Already up to date."; fi
else
  git clone https://github.com/golang/vscode-go
  cd vscode-node-debug2 || exit
  npm install
  npm run compile
fi

# tmux integration
cd "$current_dir" || exit
cp scripts/start_debugger.sh "$dap_dir"

cd "$current_dir" || exit
