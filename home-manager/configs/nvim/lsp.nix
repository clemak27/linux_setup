{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
  updateNvim = pkgs.writeShellScriptBin "update-nvim-dev" (
    builtins.readFile (./. + "/setup_nvim_dev.sh") +
    config.nvimUpdate.setupCommands
  );
in
{
  imports = [
    ./latex.nix
    ./vue.nix
    ./node.nix
    ./go.nix
    ./java.nix
    ./markdown.nix
    ./neovim.nix
    ./shell.nix
    ./nix.nix
    ./yaml.nix
    ./web.nix
    ./lint.nix
    ./lsp_dap.nix
  ];

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

  config = {
    home.packages = with pkgs; [
      updateNvim
    ];

    nvimUpdate.setupCommands = "";
    nvimUpdate.lspDir = "$HOME/.local/bin/nvim/lsp";
    nvimUpdate.dapDir = "$HOME/.local/bin/nvim/dap";
  };
}
