# vi: ft=nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cava
    cmatrix
    fortune
    lolcat
    neofetch
    sl
    tty-clock

    ddgr
    todo-txt-cli
    tealdeer

    tmux
    tmuxinator
  ];

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}
