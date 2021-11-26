{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dotfiles;
in
{
  options.homecfg.dotfiles = {
    alacritty = lib.mkEnableOption "Manage alacritty config with home-manager";
  };

  config = lib.mkIf (cfg.alacritty) {
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./alacritty.yml;
    };
  };
}
