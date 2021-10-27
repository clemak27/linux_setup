{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  alphaBlack = pkgs.stdenv.mkDerivation {
    name = "breeze-alpha-back";
    src = ./breeze-alphablack-v20.tar.gz;
    installPhase = ''
      mkdir -p $out
      cp -R . $out
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
      xbindkeys
    ];

    # home.file.".xprofile".text = "xbindkeys";
    home.file.".xbindkeysrc".source = ./xbindkeysrc;

    home.file.".local/share/plasma/desktoptheme/breeze-alphablack".source = alphaBlack;
    home.file.".local/share/color-schemes/SkyBlue.colors".source = ./SkyBlue.colors;
  };
}
