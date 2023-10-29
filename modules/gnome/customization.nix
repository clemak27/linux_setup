{ config, lib, pkgs, ... }:
let
  jetBrainsMono = pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip";
    hash = "sha256-NJoCS5r652oSygv/zUp1YyWmZQkQ7bkqIarYMOCEL7I=";
    stripRoot = false;
  };
in
{
  imports = [
    ./dconf.nix
  ];

  config = {
    home.packages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell
      gnomeExtensions.pip-on-top

      gparted
    ];

    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Regular.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-SemiBold.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-SemiBold.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-SemiBoldItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-SemiBoldItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Thin.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Thin.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-ThinItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-ThinItalic.ttf";

    home.file.".themes" = {
      source =
        pkgs.fetchzip {
          url = "https://github.com/catppuccin/gtk/releases/download/v0.6.0/Catppuccin-Mocha-Standard-Mauve-Dark.zip";
          hash = "sha256-QJ68fQG8beGtcn/6UTMQJHnjkMuBu3Iuw428B8o1RXY=";
          stripRoot = false;
        };
      recursive = true;
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Mauve";
    };
  };
}
