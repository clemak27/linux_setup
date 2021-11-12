{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  updateHM = pkgs.writeShellScriptBin "update-home-manager" ''
    echo "Updating nix channels"
    nix-channel --update
    # echo "Upgrading nix-env"
    # nix-env --upgrade
    echo "Reloading home-manager config"
    home-manager switch

    if [ -x $(which tldr) ] ; then
      echo "Updating tealdeer cache"
      tldr --update
    fi

    if [ -x $(which nvim) ] ; then
      echo "Updating additional nvim tools"
      update-nvim-dev
    fi
  '';
in
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
    home.packages = with pkgs; [ updateHM ];
  };

}
