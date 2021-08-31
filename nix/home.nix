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
    tokei

    bat
    bottom
    exa
    fd
    fzf
    gitAndTools.gh
    hyperfine
    jq
    pgcli
    ranger
    ripgrep
    sd
    tea
    tealdeer
    todo-txt-cli
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

  # general symlinks
  home.file = {
    ".zshrc".source = ./dotfiles/zshrc;
    ".zsh_functions".source = ./dotfiles/zsh_functions;
    ".starship.toml".source = ./dotfiles/starship.toml;
    ".tmux.conf".source = ./dotfiles/tmux.conf;
    ".markdownlintrc".source = ./dotfiles/markdownlintrc;
    ".npmrc".source = ./dotfiles/npmrc;
    ".todo/config".source = ./dotfiles/todo/todo.cfg;
  };

  xdg.configFile = {
    "alacritty/alacritty.yml".source = ./dotfiles/alacritty/alacritty.yml;
    "nvim/init.vim".source = ./dotfiles/nvim/init.vim;
    "nvim/lua".source = ./dotfiles/nvim/lua;
    "ranger/rc.conf".source = ./dotfiles/ranger/ranger.rc;
    "ranger/commands.py".source = ./dotfiles/ranger/ranger.commands;
    "bat/config".source = ./dotfiles/bat/config;
    "tmuxinator".source = ./dotfiles/tmuxinator;
  };

  # not so general symlinks
  home.file.".xprofile".source = ./dotfiles/xprofile;
  home.file.".Xresources".source = ./dotfiles/Xresources;
  xdg.configFile."mpv/mpv.conf".source = ./dotfiles/mpv/mpv.conf;
  home.file.".local/share/color-schemes/SkyBlue.colors".source = ../plasma/SkyBlue.colors;

}
