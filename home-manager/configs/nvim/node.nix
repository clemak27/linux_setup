{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.node = lib.mkEnableOption "Enable tsserver, eslint and vscode-node-debug2";

  config = lib.mkIf (cfg.node && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.typescript
      nodePackages.typescript-language-server
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
