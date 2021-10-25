{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.shell = lib.mkEnableOption "Enable bash-language server and shellcheck";

  config = lib.mkIf (cfg.shell && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.bash-language-server
      shellcheck
    ];
  };
}
