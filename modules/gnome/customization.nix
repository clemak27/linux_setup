{ config, lib, pkgs, ... }:
let
  jetBrainsMono = pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip";
    hash = "sha256-M3+MvmKqiOYelJkujuqAsalxIBxb5+MBJ4uoNGV+1Fg=";
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
      gnomeExtensions.blur-my-shell
      gnomeExtensions.gsconnect
      gnomeExtensions.open-bar
      gnomeExtensions.panel-scroll
      gnomeExtensions.pip-on-top
      gnomeExtensions.unite

      hydrapaper
      celluloid
    ];

    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Bold.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Bold.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-BoldItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-BoldItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-ExtraBold.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-ExtraBold.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-ExtraBoldItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-ExtraBoldItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-ExtraLight.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-ExtraLight.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-ExtraLightItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-ExtraLightItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Italic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Italic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Light.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Light.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-LightItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-LightItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Medium.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Medium.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-MediumItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-MediumItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Regular.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-SemiBold.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-SemiBold.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-SemiBoldItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-SemiBoldItalic.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-Thin.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-Thin.ttf";
    home.file.".local/share/fonts/JetBrainsMonoNerdFont-ThinItalic.ttf".source = config.lib.file.mkOutOfStoreSymlink "${jetBrainsMono}/JetBrainsMonoNerdFont-ThinItalic.ttf";
  };
}
