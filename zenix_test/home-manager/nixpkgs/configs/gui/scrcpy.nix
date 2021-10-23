{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
in
{
  options.homecfg.gui = {
    scrcpy = lib.mkEnableOption "Manage scrcpy with home-manager";
  };

  config = lib.mkIf (cfg.scrcpy) {
    home.packages = with pkgs; [
      scrcpy
    ];
  };
}
