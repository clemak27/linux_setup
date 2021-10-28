{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.git;
in
{
  options.homecfg.git.glab = lib.mkEnableOption "Install gitlab cli";

  config = lib.mkIf (cfg.glab) {
    home.packages = with pkgs; [
      glab
    ];

    xdg.configFile = {
      "glab-cli/aliases.yml".source = ./glab_aliases.yml;
    };
  };
}
