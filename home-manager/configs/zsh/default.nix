{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.zsh;
in
{
  imports = [
    ./starship.nix
    ./direnv.nix
  ];

  options.homecfg.zsh.enable = lib.mkEnableOption "Manage zsh with home-manager";

  config = lib.mkIf (cfg.enable) {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
      };
    };

    home.file = {
      ".zshrc".source = ./zshrc;
      ".zsh_functions".source = ./zsh_functions;
    };

    xdg.configFile = {
      "starship.toml".source = ./starship.toml;
    };

  };
}
