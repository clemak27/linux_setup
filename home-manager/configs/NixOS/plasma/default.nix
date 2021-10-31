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
  eventCalendar = pkgs.stdenv.mkDerivation {
    name = "breeze-alpha-back";
    src = fetchTarball {
      url = "https://github.com/Zren/plasma-applet-eventcalendar/archive/v75.tar.gz";
      sha256 = "1jppksrfvbk5ypiqdz4cddxdl8z6zyzdb2srq8fcffr327ld5jj2";
    };
    installPhase = ''
      mkdir -p $out
      ls -hal .
      cp -R ./package $out
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
    home.file.".local/share/plasma/plasmoids/test".source = eventCalendar; # org.kde.plasma.eventcalendar
    home.file.".local/share/color-schemes/SkyBlue.colors".source = ./SkyBlue.colors;
  };
}
