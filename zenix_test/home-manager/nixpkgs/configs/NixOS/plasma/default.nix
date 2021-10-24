{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
in
{
  options.homecfg.NixOS = {
    plasma = lib.mkEnableOption "Setup KDE Plasma customization with home-manager";
  };

  config = lib.mkIf (cfg.plasma) {
    home.packages = with pkgs; [
      papirus-icon-theme
      latte-dock
    ];

    home.file.".local/share/color-schemes/SkyBlue.colors".source = ./SkyBlue.colors;

  };

}