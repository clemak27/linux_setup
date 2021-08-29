# vi: ft=nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fortune
    lolcat
    cmatrix
    lolcat
    neofetch
    sl
    cava
    tty-clock
    ddgr
    tealdeer

    tmuxinator
    todo-txt-cli
  ];

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}
