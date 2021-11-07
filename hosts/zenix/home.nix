{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/homecfg.nix
  ];

  homecfg = {
    NixOS = {
      enable = true;
      gnome = true;
      games = {
        minecraft = false;
      };
    };
    dev = {
      java = true;
      go = true;
      node = {
        enable = true;
      };
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
      snippets = true;
      telescope = true;
      lsp = {
        web = true;
        yaml = true;
        nix = true;
        shell = true;
        neovim = true;
        markdown = true;
        java = true;
        go = true;
        node = true;
        vue = true;
      };
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
