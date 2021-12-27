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

  home.file."mp3gain.bash".source = ./mp3gain.bash;

  home.packages = with pkgs; [
    gcc
    neofetch
    mp3gain
  ];
}
