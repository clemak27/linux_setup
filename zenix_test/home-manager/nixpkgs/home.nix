{ config, pkgs, lib, ... }:

{
  imports = [
    ./homecfg.nix
  ];

  homecfg = {
    NixOS = {
      enable = true;
      plasma = true;
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
    gui = {
      alacritty = true;
      firefox = true;
      intelliJ = false;
      mpv = true;
      scrcpy = true;
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
