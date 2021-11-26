{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
  updateNvim = pkgs.writeShellScriptBin "update-nvim-dev" (
    builtins.readFile (./. + "/setup_nvim_dev.sh") +
    config.nvimUpdate.setupCommands
  );
in
{
  imports = [
    ./go_tools.nix
    ./java_tools.nix
    ./node_tools.nix
  ];

  options.homecfg.dev.tools = lib.mkEnableOption "Enable a script to update development tools not managed by nix";

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

  config = lib.mkIf (cfg.tools) {
    home.packages = with pkgs; [
      updateNvim
    ];

    nvimUpdate.setupCommands = "";
    nvimUpdate.lspDir = "$HOME/.local/bin/nvim/lsp";
    nvimUpdate.dapDir = "$HOME/.local/bin/nvim/dap";
  };
}
