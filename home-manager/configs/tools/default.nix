{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tools;
  stable = if config.homecfg.NixOS.enable then import <nixos-stable> { } else import <nixpkgs-stable> { };
in
{
  imports = [
    ./tealdeer_update.nix
  ];

  options.homecfg.tools.enable = lib.mkEnableOption "Manage command line tools with homecfg";

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      bat
      bat-extras.batman
      bottom
      curl
      exa
      fd
      hyperfine
      jq
      stable.pgcli
      ranger
      ripgrep
      sd
      tealdeer
      timewarrior
      todo-txt-cli
      tree
      ueberzug
    ] ++ lib.optionals stdenv.isLinux [
      android-tools
    ];

    home.file.".oh-my-zsh/custom/plugins/timewarrior".source =
      builtins.fetchGit {
        url = "https://github.com/svenXY/timewarrior.git";
        ref = "master";
        rev = "083d40edfa0b0a64d84a23ee370097beb43d4dd8";
      };

    home.file.".config/ranger/plugins/ranger_devicons".source =
      builtins.fetchGit {
        url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
        ref = "main";
        rev = "11941619b853e9608a41028ac8ebde2e6ca7d934";
      };

    programs.fzf = {
      enable = true;
      defaultCommand = "rg --files --hidden";
      defaultOptions = [ "--height=50%" "--layout=reverse" "--info=inline" "--border=sharp" "--margin=1" "--padding=1" ];
    };

    programs.zsh.oh-my-zsh.plugins = [
      "fd"
      "fzf"
      "ripgrep"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "cat"; value = "bat"; }
        { name = "ls"; value = "exa --icons"; }
        { name = "lsa"; value = "exa --icons -hal"; }
        { name = "man"; value = "batman"; }
        { name = "todo"; value = "todo.sh"; }
      ]
    );

    home.file = {
      ".todo/config".source = ./todo/todo.cfg;
      ".local/bin/rfv".source = ./rfv;
    };

    xdg.configFile = {
      "ranger/rc.conf".source = ./ranger/ranger.rc;
      "ranger/commands.py".source = ./ranger/ranger.commands;
      "bat/config".source = ./bat/config;
    };
  };
}
