{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dotfiles;
  alaCfg = if pkgs.stdenv.isLinux then ./alacritty.yml else ./alacritty_mac.yml;
in
{
  options.homecfg.dotfiles = {
    alacritty = lib.mkEnableOption "Manage alacritty config with home-manager";
  };

  config = lib.mkIf (cfg.alacritty) {
    xdg.configFile = {
      "alacritty/alacritty.yml".source =  alaCfg;
    };
  };
}
