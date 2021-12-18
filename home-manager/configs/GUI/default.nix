{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.GUI;
  stable = import <nixos-stable> { };
in
{
  options.homecfg.GUI = {
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
      "MangoHud/MangoHud.conf".source = ./MangoHud.conf;
    };

    home.file.".xprofile".source = ./xprofile;
    home.file.".Xresources".source = ./Xresources;
  };
}
