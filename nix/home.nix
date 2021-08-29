{ pkgs, ... }:

{
  home.packages = with pkgs; [
    direnv

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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # optional for nix flakes support
  # programs.direnv.nix-direnv.enableFlakes = true;
  
  # programs.zsh.enable = true;
  
}
