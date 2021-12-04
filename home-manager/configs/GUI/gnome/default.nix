{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.GUI;
in
{
  options.homecfg.GUI = {
    gnome = lib.mkEnableOption "Setup GNOME customization with home-manager";
  };

  config = lib.mkIf (cfg.enable && cfg.gnome) {
    home.packages = with pkgs; [
      papirus-icon-theme

      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell

      gimp
      gparted
      libreoffice
    ];

    dconf.settings = import ./dconf.nix;
  };
}
