{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.vue = lib.mkEnableOption "Enable vuejs lsp";

  config = lib.mkIf (cfg.vue && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.vls
    ];
  };
}
