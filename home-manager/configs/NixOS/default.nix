{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  stable = import <nixos-stable> { };
in
{
  imports = [
    ./plasma
    ./games
  ];

  options.homecfg.NixOS = {
    enable = lib.mkEnableOption "Set to true if home-manager is running on NixOS";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      keepassxc
      scrcpy
      krita
      kdeconnect

      kdenlive
      obs-studio

      stable.sublime-music
      kid3

      discord
      signal-desktop

      unrar
      ytfzf
      sshfs

      libreoffice-qt
    ];

    programs.rofi.enable = true;

    programs.alacritty.enable = true;
    programs.firefox.enable = true;
    programs.mpv.enable = true;
    services.syncthing.enable = true;

    home.file.".xprofile".source =  ./xprofile;
    home.file.".Xresources".source = ./Xresources;
  };
}
