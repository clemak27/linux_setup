{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.GUI;
  stable = import <nixos-stable> { };
in
{
  imports = [
    ./gnome
  ];

  options.homecfg.GUI = {
    enable = lib.mkEnableOption "Set to enable GUI programs";
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

    xdg.configFile = {
      "MangoHud/MangoHud.conf".source = ./MangoHud.conf;
    };

    home.file.".xprofile".source = ./xprofile;
    home.file.".Xresources".source = ./Xresources;
  };
}
