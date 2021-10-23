{ config, lib, pkgs, ... }:
{
  imports = [
    ./colors.nix
    ./configs/dev/default.nix
    ./configs/fun/default.nix
    ./configs/k8s/default.nix
    ./configs/git/default.nix
    ./configs/gui/default.nix
    ./configs/nvim/default.nix
    ./configs/tmux/default.nix
    ./configs/tools/default.nix
    ./configs/zsh/default.nix
  ];

  options.homecfg = {
    nixOS = lib.mkEnableOption "Set to true if home-manager is running on nixOS";
  };

  config = {
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    # optional for nix flakes support
    # programs.direnv.nix-direnv.enableFlakes = true;
  };

}
