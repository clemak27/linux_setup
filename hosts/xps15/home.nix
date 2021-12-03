{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/homecfg.nix
  ];

  homecfg = {
    GUI = {
      enable = true;
      gnome = true;
      games = {
        minecraft = true;
      };
    };
    dev = {
      java = true;
      go = true;
      node = {
        enable = true;
      };
      tools = true;
    };
    fun = {
      enable = true;
    };
    k8s = {
      enable = true;
      localDev = true;
    };
    dotfiles = {
      alacritty = true;
      ideavim = false;
      mpv = true;
    };
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
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
