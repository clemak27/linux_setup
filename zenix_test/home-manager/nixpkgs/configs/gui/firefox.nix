{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
in
{
  options.homecfg.gui = {
    firefox = lib.mkEnableOption "Manage firefox with home-manager";
  };

  config = lib.mkIf (cfg.firefox) {
    programs.firefox = {
      enable = config.homecfg.NixOS.enable;
    };
  };
}
