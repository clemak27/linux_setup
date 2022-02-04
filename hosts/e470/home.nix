{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home-manager/homecfg.nix
  ];

  homecfg = {
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
    };
    nvim.enable = true;
    tmux.enable = true;
    tools.enable = true;
    zsh.enable = true;
  };

  home.file."mp3gain-update.sh".source = ./mp3gain-update.sh;
  home.file."gitops-upgrade.sh".source = ./gitops-upgrade.sh;

  home.packages = with pkgs; [
    gcc
    neofetch
    mp3gain
  ];
}
