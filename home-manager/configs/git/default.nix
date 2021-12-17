{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg;
in
{
  imports = [
    ./tea.nix
    ./github.nix
    ./glab.nix
  ];

  options.homecfg.git.enable = lib.mkEnableOption "Manage git with home-manager";

  config = lib.mkIf (cfg.git.enable) {
    programs.git = {
      enable = cfg.git.enable;
    };

    programs.git.delta = {
      enable = cfg.git.enable;
    };

    xdg.configFile = {
      "git/config".source = ./gitconfig;
    };
  };
}
