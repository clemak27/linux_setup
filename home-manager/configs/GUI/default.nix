{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.GUI;
  stable = import <nixos-stable> { };
in
{
  imports = [
    ./gnome
    ./games
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
    programs.zsh = {
      shellAliases = builtins.listToAttrs (
        [
          { name = "mpvnv"; value = "mpv --no-video"; }
          { name = "youtube-dl-music"; value = "youtube-dl --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
        ]
      );
    };
    home.file.".xprofile".source = ./xprofile;
    home.file.".Xresources".source = ./Xresources;
  };
}
