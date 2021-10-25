{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dotfiles;
in
{
  options.homecfg.dotfiles = {
    mpv = lib.mkEnableOption "Manage mpv config with home-manager";
  };

  config = lib.mkIf (cfg.mpv) {
    xdg.configFile = {
      "mpv/mpv.conf".source = ./mpv.conf;
    };
  };
}
