{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.git;
in
{
  options.homecfg.git.gh = lib.mkEnableOption "Install github cli";

  config = lib.mkIf (cfg.gh) {
    home.packages = with pkgs; [
      gitAndTools.gh
    ];
  };
}
