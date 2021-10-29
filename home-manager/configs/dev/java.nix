{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
in
{
  options.homecfg.dev.java = lib.mkEnableOption "Manage java with home-manager";

  config = lib.mkIf (cfg.java) {
    home.packages = with pkgs; [
      gradle
    ];

    programs.java = {
      enable = true;
      package = pkgs.jdk;
    };
  };
}
