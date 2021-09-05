{ config, pkgs, lib,... }:

{
  imports = [
    ./homecfg.nix
  ];

  homecfg = {
    dev = {
      node = true;
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
