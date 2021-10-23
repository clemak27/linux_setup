{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.dev;
in
{
  options.homecfg.dev.node = {
    enable = lib.mkEnableOption "Manage nodejs with home-manager";
    registry = lib.mkOption {
      type = lib.types.str;
      default = "https://registry.npmjs.org";
      description = "The repository npm will use to fetch packages.";
    };
    exact = lib.mkEnableOption "If save-exact should be set to true";
  };

  config = lib.mkIf (cfg.node.enable) {
    home.packages = with pkgs; [
      nodejs
      yarn
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "npm"
    ];

    home.file.".npmrc".text = ''
      prefix=~/.local/bin/npm
      registry=${cfg.node.registry}
      save_exact=${if cfg.node.exact then "true" else "false"}
    '';
  };
}
