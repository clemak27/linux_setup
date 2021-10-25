{ config, pkgs, lib,... }:

{
  imports = [
    ./homecfg.nix
  ];

  homecfg = {
    nixOS = false;
    dev = {
      java = true;
      go = true;
      node = {
        enable = true;
        exact = true;
      };
    };
    fun = {
      enable = true;
    };
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      tea = true;
      gh = true;
    };
    gui = {
      alacritty = true;
      mpv = true;
      scrcpy = true;
    };
    k8s = {
      enable = true;
      localDev = true;
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
        latex = true;
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
