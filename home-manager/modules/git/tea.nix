{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.git;
in
{
  options.homecfg.git.tea = lib.mkEnableOption "Install gitea cli";

  config = lib.mkIf (cfg.tea) {
    home.packages = with pkgs; [
      tea
    ];
  };
}
