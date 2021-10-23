{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
  alaCfg = if pkgs.stdenv.isLinux then ./alacritty.yml else ./alacritty_mac.yml;
in
{
  options.homecfg.gui = {
    alacritty = lib.mkEnableOption "Manage alacritty with home-manager";
  };

  config = lib.mkIf (cfg.alacritty) {

    # https://github.com/NixOS/nixpkgs/issues/80702
    # https://github.com/NixOS/nixpkgs/issues/122671
    # https://github.com/guibou/nixGL/
    programs.alacritty = {
      enable = config.homecfg.nixOS;
    };

    xdg.configFile = {
      "alacritty/alacritty.yml".source =  alaCfg;
    };
  };
}
