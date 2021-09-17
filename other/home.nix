{ config, pkgs, lib,... }:

{
  imports = [
    ./homecfg.nix
  ];

  homecfg = {
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
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      tea = true;
      gh = true;
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
