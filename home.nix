{ config, pkgs, lib, ... }:

{
  imports = [
    ./home-manager/homecfg.nix
  ];

  homecfg = {
    dev.enable = true;
    fun.enable = true;
    k8s.enable = true;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      tea = true;
      gh = true;
      glab = false;
    };
    nvim.enable = true;
    tmux.enable = true;
    tools.enable = true;
    zsh.enable = true;
  };
}
