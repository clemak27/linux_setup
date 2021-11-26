{ config, lib, pkgs, ... }:
{
  imports = [
    ./colors.nix
    ./configs/dev
    ./configs/fun
    ./configs/k8s
    ./configs/git
    ./configs/dotfiles
    ./configs/NixOS
    ./configs/nvim
    ./configs/tmux
    ./configs/tools
    ./configs/zsh
  ];

  config = {
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    # optional for nix flakes support
    # programs.direnv.nix-direnv.enableFlakes = true;
  };

}
