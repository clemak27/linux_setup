# paths
install_dir="$HOME/.local/bin/dev"
lsp_dir="$install_dir/lsp"
dap_dir="$install_dir/dap"
current_dir=$(pwd)

# create folders
mkdir -p "$lsp_dir"
mkdir -p "$dap_dir"

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

cd "$current_dir" || exit
