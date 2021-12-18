{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
  stable = import <nixos-stable> { };
in
{
  options.homecfg.gui = {
    enable = lib.mkEnableOption "Set to enable GUI programs";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      papirus-icon-theme

      gnomeExtensions.appindicator
      gnomeExtensions.unite
      gnomeExtensions.gsconnect
      gnomeExtensions.blur-my-shell

      gparted
      keepassxc

      stable.sublime-music
      kid3

      discord

      scrcpy

      youtube-dl
      unrar
      ytfzf
      sshfs
    ];

    dconf.settings = import ./dconf.nix;

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

    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./alacritty.yml;
      "MangoHud/MangoHud.conf".source = ./MangoHud.conf;
      "mpv/mpv.conf".source = ./mpv.conf;
    };
    home.file = {
      ".ideavimrc".source = ./ideavimrc;
      ".xprofile".source = ./xprofile;
      ".Xresources".source = ./Xresources;
    };
  };
}