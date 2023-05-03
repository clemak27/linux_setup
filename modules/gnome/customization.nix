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

      gparted
    ];

    home.file.".local/share/fonts" = {
      source =
        pkgs.fetchzip {
          url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/FiraCode.zip";
          hash = "sha256-cLn0Tbh+VCNbiBkHvomJ2iwhfW/ZZhPkncrLJzzxQJs=";
          stripRoot = false;
        };
      recursive = true;
    };

    home.file.".themes" = {
      source =
        pkgs.fetchzip {
          url = "https://github.com/catppuccin/gtk/releases/download/v0.5.0/Catppuccin-Mocha-Standard-Mauve-Dark.zip";
          hash = "sha256-DIggJCLHHTvwNeNg2+YCz4KDdlYO0CbYiXCaozyevLA=";
          stripRoot = false;
        };
      recursive = true;
    };
  };
}
