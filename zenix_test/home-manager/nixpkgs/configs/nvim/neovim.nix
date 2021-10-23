{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.neovim = lib.mkEnableOption "Enable vim and lua ls";

  config = lib.mkIf (cfg.neovim && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.vim-language-server
    ];

    nvimUpdate.setupCommands = ''
      lsp_dir="${config.nvimUpdate.lspDir}"
      dap_dir="${config.nvimUpdate.dapDir}"
      current_dir=$(pwd)

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

      cd "$current_dir" || exit
    '';
  };
}
