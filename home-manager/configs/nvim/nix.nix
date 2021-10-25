{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.nix = lib.mkEnableOption "Enable rnix-lsp, the work-in-progress language server for Nix";

  config = lib.mkIf (cfg.nix) {

    home.packages = with pkgs; [
      rnix-lsp
    ];
  };
}
