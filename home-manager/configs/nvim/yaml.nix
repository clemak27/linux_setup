{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.yaml = lib.mkEnableOption "Enable yaml lsp";

  config = lib.mkIf (cfg.yaml && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.yaml-language-server
    ];
  };
}
