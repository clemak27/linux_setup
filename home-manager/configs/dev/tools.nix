{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
  updateDevTools = pkgs.writeShellScriptBin "update-dev-tools" (
    builtins.readFile (./. + "/setup_dev_tools.sh") +
    config.devTools.setupCommands
  );
in
{
  imports = [
    ./go_tools.nix
    ./java_tools.nix
    ./node_tools.nix
    ./dev_tools_update.nix
  ];

  options.homecfg.dev.tools = lib.mkEnableOption "Enable a script to update development tools not managed by nix";

  options.devTools = {
    lspDir = lib.mkOption {
      type = lib.types.lines;
      default = "$HOME/.local/bin/dev/lsp";
    };

    dapDir = lib.mkOption {
      type = lib.types.lines;
      default = "$HOME/.local/bin/dev/dap";
    };

    setupCommands = lib.mkOption {
      type = lib.types.lines;
    };
  };

  config = lib.mkIf (cfg.tools) {
    home.packages = with pkgs; [
      updateDevTools
    ];

    devTools.setupCommands = "";
    devTools.lspDir = "$HOME/.local/bin/dev/lsp";
    devTools.dapDir = "$HOME/.local/bin/dev/dap";
  };
}
