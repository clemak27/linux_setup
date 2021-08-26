#!/bin/sh

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

# gopls
go install golang.org/x/tools/gopls@latest

# jdtls
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
  fi
else
  curl -O http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
  mkdir -p jdtls
  tar -xzvf jdt-language-server-latest.tar.gz -C ./jdtls
  echo "$latest" > current_jdtls.txt
fi

unset "$latest"
unset "$current"

# --------------------------- linter ---------------------------

echo "Updating linter"

update_node_package markdownlint-cli
update_node_package eslint

go install github.com/mgechev/revive@latest
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
go install github.com/go-delve/delve/cmd/dlv@latest
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
