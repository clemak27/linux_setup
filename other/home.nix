{ config, pkgs, lib,... }:

{
  imports = [
    ./homecfg.nix
  ];

  homecfg = {
    dev = {
      node = {
        enable = true;
      };
      java = true;
      go = true;
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
      advanced = {
        markdown = true;
        java = true;
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
