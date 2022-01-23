{ config, lib, pkgs, ... }:
{
  imports = [
    ./colors.nix
    ./modules/dev
    ./modules/fun
    ./modules/k8s
    ./modules/git
    ./modules/gui
    ./modules/nvim
    ./modules/tmux
    ./modules/tools
    ./modules/zsh
  ];

  config = {
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
  };

}
