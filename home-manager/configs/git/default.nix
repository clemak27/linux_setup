{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg;
in
{
  imports = [
    ./tea.nix
    ./github.nix
    ./glab.nix
  ];

  options.homecfg.git = {
    enable = lib.mkEnableOption "Manage git with home-manager";

    user = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The username of the git user.";
      example = "john";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The email of the git user.";
      example = "john.doe@example.com";
    };
  };

  config = lib.mkIf (cfg.git.enable) {
    programs.git = {
      enable = cfg.git.enable;
      userName = "${cfg.git.user}";
      userEmail = "${cfg.git.email}";
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
      enable = cfg.git.enable;
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

    programs.zsh.oh-my-zsh.plugins = [
      "git"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "gcm"; value = "git commit -v -m"; }
        { name = "gcmld"; value = ''git checkout master && git pull && comm -12 <(git branch | sed "s/ *//g") <(git remote prune origin --dry-run | sed "s/^.*origin\///g") | xargs -I'{}' git branch -D {}''; }
        { name = "gdm"; value = "git diff --cached master"; }
        { name = "gfmm"; value = "git fetch origin && git merge origin/master"; }
        { name = "gprom"; value = "git pull --rebase origin master"; }
        { name = "gpskip"; value = "git push -o ci.skip"; }
        { name = "gs"; value = "git status"; }
        { name = "gus"; value = "git reset HEAD"; }
      ]
    );
  };
}
