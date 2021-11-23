{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/homecfg.nix
  ];

  homecfg = {
    fun = {
      enable = true;
    };
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
    };
    nvim = {
      enable = false;
      snippets = false;
      telescope = false;
    };
    tools = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };
}
