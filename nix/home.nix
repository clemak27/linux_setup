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

    bat
    bottom
    ddgr
    delta
    exa
    fd
    hyperfine
    jq
    ncdu
    ranger
    ripgrep
    sd
    tea
    tealdeer
    todo-txt-cli
    tokei

    tmux
    tmuxinator
  ];

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}
