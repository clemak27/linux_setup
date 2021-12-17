{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tmux;
  colors = config.homecfg.colors;
in
{
  options.homecfg.tmux.enable = lib.mkEnableOption "Manage tmux with home-manager";

  config = lib.mkIf (cfg.enable) {

    programs.tmux = {
      enable = true;
      tmuxinator.enable = true;
    };

    xdg.configFile = {
      "tmux/tmux.conf".source = ./tmux.conf;
      "tmuxinator".source = ./tmuxinator;
    };
  };
}
