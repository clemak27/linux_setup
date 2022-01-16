{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.fun;
in
{
  options.homecfg.fun.enable = lib.mkEnableOption "Manage fun things with home-manager";

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      cmatrix
      figlet
      fortune
      lolcat
      neofetch
      pipes
      sl
      tokei
      tty-clock
    ] ++ lib.optionals stdenv.isLinux [
      cava
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "cmatrix"; value = "cmatrix -C blue"; }
      ]
    );
  };

}
