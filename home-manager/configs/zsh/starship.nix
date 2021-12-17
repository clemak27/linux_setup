{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.zsh;
in
{
  config = lib.mkIf (cfg.enable) {
    programs.starship.enable = true;
  };
}

