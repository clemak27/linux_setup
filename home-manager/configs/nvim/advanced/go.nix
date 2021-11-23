{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.advanced && config.homecfg.dev.go && config.homecfg.dev.node.enable) {
    nvimUpdate.setupCommands = ''
      lsp_dir="${config.nvimUpdate.lspDir}"
      dap_dir="${config.nvimUpdate.dapDir}"
      current_dir=$(pwd)

      if [[ $(go install golang.org/x/tools/gopls@latest) ]]; then
        echo "[gopls] Updated."
      else
        echo "[gopls] Already up to date."
      fi

      if [[ $(go install github.com/mgechev/revive@latest) ]]; then
        echo "[revive] Updated."
      else
        echo "[revive] Already up to date."
      fi

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
        cd vscode-go || exit
        npm install
        npm run compile
      fi

      cd "$current_dir" || exit
    '';
  };
}