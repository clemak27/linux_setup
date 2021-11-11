{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
in
{
  options.homecfg.dev.go = lib.mkEnableOption "Manage go with home-manager";

  config = lib.mkIf (cfg.go) {

    programs.go = {
      enable = true;
      package = pkgs.go_1_17;
      goPath = ".go";
    };

    programs.zsh.oh-my-zsh.plugins = [
      "golang"
    ];
  };
}
