{ config, lib, pkgs, ... }:
{
  imports = [
    ./colors.nix
    ./configs/dev/default.nix
    ./configs/fun/default.nix
    ./configs/k8s/default.nix
    ./configs/git/default.nix
    ./configs/gui/default.nix
    ./configs/NixOS/default.nix
    ./configs/nvim/default.nix
    ./configs/tmux/default.nix
    ./configs/tools/default.nix
    ./configs/zsh/default.nix
  ];

  config = {
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    # optional for nix flakes support
    # programs.direnv.nix-direnv.enableFlakes = true;
  };

}
