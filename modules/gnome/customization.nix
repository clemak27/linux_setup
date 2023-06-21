{ config, lib, pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];

  config = {
    home.packages = with pkgs; [
      # papirus-icon-theme
      # adw-gtk3

      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell
      gnomeExtensions.pip-on-top

      gparted
    ];

    home.file.".local/share/fonts" = {
      source =
        pkgs.fetchzip {
          url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip";
          hash = "sha256-HIY7m1xE9eTLZvdgvguRs4YX3VMGlAxMoykOPDL8/Fg=";
          stripRoot = false;
        };
      recursive = true;
    };

    home.file.".themes" = {
      source =
        pkgs.fetchzip {
          url = "https://github.com/catppuccin/gtk/releases/download/v0.6.0/Catppuccin-Mocha-Standard-Mauve-Dark.zip";
          hash = "sha256-QJ68fQG8beGtcn/6UTMQJHnjkMuBu3Iuw428B8o1RXY=";
          stripRoot = false;
        };
      recursive = true;
    };
  };
}
