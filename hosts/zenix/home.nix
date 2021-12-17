{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/homecfg.nix
  ];

  homecfg = {
    GUI = {
      enable = true;
    };
    dev.enable = true;
    fun = {
      enable = true;
    };
    k8s = {
      enable = true;
    };
    dotfiles = {
      alacritty = true;
      ideavim = false;
      mpv = true;
    };
    git = {
      enable = true;
      tea = true;
      gh = true;
      glab = false;
    };
    nvim = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    tools = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };
}
