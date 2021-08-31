{ pkgs, ... }:

{
  home.packages = with pkgs; [
    direnv

    cava
    cmatrix
    fortune
    lolcat
    neofetch
    pipes
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
    pgcli
    gitAndTools.gh

    tmux
    tmuxinator

    go
    jdk
    gradle
    nodejs
    yarn
  ];

  programs.home-manager = {
    enable = true;
    path = "…";
  };

  programs.git = {
    enable = true;
    userName = "clemak27";
    userEmail = "clemak27@mailbox.org";
    aliases = {
      lol = "log --graph --decorate --oneline --all";
    };
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      credential = {
        helper = "cache";
      };
      pull = {
        rebase = "false";
      };
    };
  };

  programs.git.delta = {
    enable = true;
    options = {
      core = {
        pager = "delta";
      };
      features = "line-numbers decorations";
      syntax-theme = "base16";
      plus-style = "syntax '#1f3623'";
      minus-style = "syntax '#4a2324'";
      plus-emph-style = "normal '#335114'";
      minus-emph-style = "normal '#511414'";
      decorations = {
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow ul";
        file-decoration-style = "none";
        hunk-header-decoration-style = "blue box ul";
      };
      line-numbers = {
        line-numbers-left-style = "blue";
        line-numbers-right-style = "blue";
        line-numbers-minus-style = "red";
        line-numbers-plus-style = "green";
      };
    };
  };


  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # optional for nix flakes support
  # programs.direnv.nix-direnv.enableFlakes = true;
  
  # programs.zsh.enable = true;
  
}
