{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dotfiles;
in
{
  options.homecfg.dotfiles = {
    ideavim = lib.mkEnableOption "Manage ideavim config with home-manager.";
  };

  config = lib.mkIf (cfg.ideavim) {
    home.file = {
      ".ideavimrc".source = ./ideavimrc;
    };
  };
}
