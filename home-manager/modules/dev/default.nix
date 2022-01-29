{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
in
{
  options.homecfg.dev.enable = lib.mkEnableOption "Manage development tools with home-manager";

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      nodejs-14_x
      yarn

      gradle

      gcc
      gnumake
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "npm"
      "golang"
    ];

    home.file.".npmrc".text = ''
      prefix=~/.local/bin/npm
      save_exact=true
    '';

    programs.java = {
      enable = true;
      package = pkgs.jdk11;
    };

    programs.go = {
      enable = true;
      package = pkgs.go_1_17;
      goPath = ".go";
    };

  };

}
