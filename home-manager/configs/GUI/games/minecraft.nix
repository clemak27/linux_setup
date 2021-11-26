{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.GUI;
in
{
  options.homecfg.GUI.games = {
    minecraft = lib.mkEnableOption "Set to true to setup minecraft";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      multimc
    ];

    # TODO: setup dockerfile for local server
  };
}
