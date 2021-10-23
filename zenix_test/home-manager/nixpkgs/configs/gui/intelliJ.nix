{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.gui;
in
{
  options.homecfg.gui = {
    intelliJ = lib.mkEnableOption "Manage intelliJ with home-manager. Currently this only links the .ideavimrc";
  };

  config = lib.mkIf (cfg.intelliJ) {

    home.file = {
      ".ideavimrc".source = ./ideavimrc;
    };
  };
}
