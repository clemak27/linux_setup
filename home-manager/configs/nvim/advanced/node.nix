{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.advanced && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vls
      nodePackages.eslint
    ];

    nvimUpdate.setupCommands = ''
      lsp_dir="${config.nvimUpdate.lspDir}"
      dap_dir="${config.nvimUpdate.dapDir}"
      current_dir=$(pwd)

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

      cd "$current_dir" || exit
    '';
  };
}