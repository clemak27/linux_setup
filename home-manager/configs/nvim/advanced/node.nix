{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.advanced && config.homecfg.dev.tools) {
    home.packages = with pkgs; [
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vls
      nodePackages.eslint
    ];
  };
}
