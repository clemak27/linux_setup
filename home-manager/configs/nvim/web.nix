{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.web = lib.mkEnableOption "Enable html, css and json language server";

  config = lib.mkIf (cfg.web && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.vscode-langservers-extracted
    ];
  };
}
