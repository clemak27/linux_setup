{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
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

      sublime-music
      kid3
      sshfs

      scrcpy

      yt-dlp
      unrar
      ytfzf
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
          { name = "youtube-dl"; value = "yt-dlp"; }
          { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
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
