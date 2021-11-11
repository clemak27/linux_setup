{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
in
{
  options.homecfg.dev.go = lib.mkEnableOption "Manage go with home-manager";

  config = lib.mkIf (cfg.go) {
    home.packages = with pkgs; [
      go_1_17
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "golang"
    ];
  };
}
