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
    name = "eventCalendar";
    src = fetchTarball {
      url = "https://github.com/Zren/plasma-applet-eventcalendar/archive/v75.tar.gz";
      sha256 = "0sq35jrgjv2pwy5l90nxxqqswp4ph1p2p1hj73x11i4yxx7fhmgd";
    };
    installPhase = ''
      mkdir -p $out
      cp -R ./package/* $out
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
    home.file.".local/share/plasma/plasmoids/org.kde.plasma.eventcalendar".source = eventCalendar;
    home.file.".local/share/color-schemes/SkyBlue.colors".source = ./SkyBlue.colors;
  };
}
