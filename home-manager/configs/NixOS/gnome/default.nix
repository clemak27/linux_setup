{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  candyIcons = pkgs.stdenv.mkDerivation {
    name = "candy-icons";
    src = ./candy-icons.tar.gz;
    installPhase = ''
      mkdir -p $out
      cp -R . $out
    '';
  };
  adwaitaVioletDark = pkgs.stdenv.mkDerivation {
    name = "Adwaita-violet-dark";
    src = ./Adwaita-violet-dark.tar.gz;
    installPhase = ''
      mkdir -p $out
      cp -R . $out
    '';
  };
in
{
  options.homecfg.NixOS = {
    gnome = lib.mkEnableOption "Setup GNOME customization with home-manager";
  };

  config = lib.mkIf (cfg.enable && cfg.gnome) {
    home.packages = with pkgs; [

      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell

      gimp
      gparted
      libreoffice
    ];

    dconf.settings = import ./dconf.nix;

    home.file.".themes/Adwaita-violet-dark".source = adwaitaVioletDark;
    home.file.".local/share/icons/candy-icons".source = candyIcons;
  };
}
