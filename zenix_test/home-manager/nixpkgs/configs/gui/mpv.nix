{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
in
{
  options.homecfg.gui = {
    mpv = lib.mkEnableOption "Manage mpv with home-manager";
  };

  config = lib.mkIf (cfg.mpv) {

    programs.mpv = {
      enable = config.homecfg.NixOS.enable;
    };

    xdg.configFile = {
      "mpv/mpv.conf".source = ./mpv.conf;
    };
  };
}
