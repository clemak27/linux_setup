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

    home.file.".icons/Catppuccin-Mocha-Dark-Cursors".source =
      pkgs.fetchzip {
        url = "https://github.com/catppuccin/cursors/releases/download/v0.2.0/Catppuccin-Mocha-Dark-Cursors.zip";
        hash = "sha256-I/QSk9mXrijf3LBs93XotbxIwe0xNu5xbtADIuGMDz8=";
      };

    home.file.".themes".source =
      pkgs.fetchzip {
        url = "https://github.com/catppuccin/gtk/releases/download/v0.4.3/Catppuccin-Mocha-Standard-Mauve-Dark.zip";
        hash = "sha256-Xekj0HAVG9C7gaHJGmhMK98c5bA3vSEPE7tHFJSm33U=";
        stripRoot = false;
      };

    home.file.".local/share/fonts".source =
      pkgs.fetchzip {
        url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip";
        hash = "sha256-rXRHi5B867H25I1I2bD2idjbdv9kcQbkv4j00npREiU=";
        stripRoot = false;
      };
  };
}
