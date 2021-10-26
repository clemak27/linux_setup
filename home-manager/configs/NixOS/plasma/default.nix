{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  alphaBlack = pkgs.stdenv.mkDerivation {
    name = "breeze-alpha-back";
    src = ./breeze-alphablack-v20.tar.gz;
    installPhase = ''
      ls -hal
      mkdir -p $out
      cp -R . $out
      ls -hal $out
    '';
  };
in
{
  options.homecfg.NixOS = {
    plasma = lib.mkEnableOption "Setup KDE Plasma customization with home-manager";
  };

  config = lib.mkIf (cfg.enable && cfg.plasma) {
    home.packages = with pkgs; [
      papirus-icon-theme
      latte-dock
      ark
      partition-manager
    ];

    home.file.".local/share/plasma/desktoptheme/breeze-alphablack".source = alphaBlack;
    home.file.".config/breezerc".source = ./breezerc;
    home.file.".config/plasmarc".source = ./plasmarc;
    home.file.".local/share/color-schemes/SkyBlue.colors".source = ./SkyBlue.colors;
  };
}
