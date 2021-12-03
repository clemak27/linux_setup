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

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "trwp"; value = "tmux rename-window '#{b:pane_current_path}'"; }
      ]
    );

    xdg.configFile = {
      "tmux/tmux.conf".source = ./tmux.conf;
      "tmuxinator".source = ./tmuxinator;
    };
  };
}
