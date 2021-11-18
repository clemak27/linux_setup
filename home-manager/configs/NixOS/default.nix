{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  stable = import <nixos-stable> { };
in
{
  imports = [
    ./plasma
    ./gnome
    ./games
  ];

  options.homecfg.NixOS = {
    enable = lib.mkEnableOption "Set to true if home-manager is running on NixOS";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      keepassxc
      scrcpy

      kdenlive
      obs-studio

      stable.sublime-music
      kid3

      discord
      signal-desktop

      youtube-dl
      unrar
      ytfzf
      sshfs
    ];

    programs.rofi.enable = true;

    programs.alacritty.enable = true;
    programs.firefox = {
      enable = true;
    };

    programs.mpv.enable = true;
    services.syncthing.enable = true;

    home.file.".xprofile".source = ./xprofile;
    home.file.".Xresources".source = ./Xresources;
  };
}
