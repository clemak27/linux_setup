{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/homecfg.nix
    ./duckdns.nix
  ];

  homecfg = {
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      tea = false;
      gh = false;
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

  home.packages = [
    pkgs.gcc
  ];
}
