{ config, lib, pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];

  config = {
    home.packages = with pkgs; [
      papirus-icon-theme
      adw-gtk3

      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell

      gparted
    ];

    # dconf.settings = import ./dconf.nix;

    # TODO install from git repo like this
    # curl -L -o /tmp/cm.zip --url https://github.com/catppuccin/gtk/releases/download/v0.4.1/Catppuccin-Mocha-Standard-Mauve-Dark.zip
    # unzip /tmp/cm.zip -d ~/.themes
    # gtk = {
    #   enable = true;
    #   theme = {
    #     name = "Catppuccin-Mocha-Standard-Mauve-Dark";
    #     package = pkgs.catppuccin-gtk.override {
    #       accents = [ "mauve" ];
    #       size = "standard";
    #       # tweaks = [ "rimless" "black" ];
    #       variant = "mocha";
    #     };
    #   };
    # };
  };
}
