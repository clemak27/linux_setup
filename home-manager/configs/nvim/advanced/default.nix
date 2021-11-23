{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
  updateNvim = pkgs.writeShellScriptBin "update-nvim-dev" (
    builtins.readFile (./. + "/setup_nvim_dev.sh") +
    config.nvimUpdate.setupCommands
  );
in
{
  imports = [
    ./latex.nix
    ./node.nix
    ./go.nix
    ./java.nix
    ./markdown.nix
    ./lint.nix
    ./lsp_dap.nix
  ];

  options.homecfg.nvim.advanced = lib.mkEnableOption "Enable neovim LSP, DAP and linting";

  options.nvimUpdate = {
    lspDir = lib.mkOption {
      type = lib.types.lines;
      default = "$HOME/.local/bin/nvim/lsp";
    };

    dapDir = lib.mkOption {
      type = lib.types.lines;
      default = "$HOME/.local/bin/nvim/dap";
    };

    setupCommands = lib.mkOption {
      type = lib.types.lines;
    };
  };

  config = lib.mkIf (cfg.advanced) {
    home.packages = with pkgs; [
      updateNvim
    ];

    nvimUpdate.setupCommands = "";
    nvimUpdate.lspDir = "$HOME/.local/bin/nvim/lsp";
    nvimUpdate.dapDir = "$HOME/.local/bin/nvim/dap";
  };
}
