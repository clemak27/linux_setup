{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  imports = [
    ./latex.nix
    ./node.nix
    ./java.nix
    ./markdown.nix
    ./lint.nix
    ./lsp_dap.nix
  ];

  options.homecfg.nvim.advanced = lib.mkEnableOption "Enable neovim LSP, DAP and linting";
}
