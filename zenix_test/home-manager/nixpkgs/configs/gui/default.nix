{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
in
{
  imports = [
    ./alacritty.nix
    ./intelliJ.nix
    ./mpv.nix
    ./scrcpy.nix
  ];

  config = {

    # workaround to find .desktop files with rofi
    # adding to PATH did nothing ¯\_(ツ)_/¯
    # https://nixos.wiki/wiki/Nix_Cookbook#Desktop_environment_does_not_find_.desktop_files
    home.file.".local/share/applications/nix".source = ~/.nix-profile/share/applications;
    home.file.".local/share/applications/nix".recursive = true;

  };
}
