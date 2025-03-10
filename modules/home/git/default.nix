{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homecfg;
  lgFullscreen = pkgs.writeShellApplication {
    name = "lg";
    runtimeInputs = with pkgs; [
      lazygit
      wezterm
    ];
    text = ''
      # bash
           wezterm cli zoom-pane --pane-id "$(wezterm cli split-pane --right --cells 1 -- lazygit)"
    '';
  };
  gcmld = pkgs.writeShellApplication {
    name = "gcmld";
    runtimeInputs = with pkgs; [ git ];
    text = # bash
      ''
        if git branch -a | grep -E 'remotes/origin/master' > /dev/null; then
          git checkout master
        else
          git checkout main
        fi

        git pull --rebase --autostash

        git remote prune origin

        branches=$(git branch --merged | grep -Ev "(^\*|master|main)" || echo "")
        if [ "$branches" != "" ]; then echo "$branches" | xargs git branch -d; fi
      '';
  };
in
{
  imports = [
    ./github.nix
    ./ssh_signing.nix
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
          rebase = "true";
        };
        rebase = {
          autoStash = "true";
        };
        fetch = {
          prune = "true";
        };
        init = {
          defaultBranch = "main";
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

    home.packages = [
      gcmld
      lgFullscreen
    ];

    programs.lazygit.enable = true;
    programs.lazygit.settings = {
      git = {
        overrideGpg = true;
      };
    };

    programs.zsh.oh-my-zsh.plugins = [
      "git"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs ([
      {
        name = "gcm";
        value = "git commit -v -m";
      }
      {
        name = "gdc";
        value = "git diff --cached";
      }
      {
        name = "gdm";
        value = "git diff --cached master";
      }
      {
        name = "gfmm";
        value = "git fetch origin && git merge origin/master";
      }
      {
        name = "gprom";
        value = "if git branch -a | grep -E 'remotes/origin/master' > /dev/null; then git pull --rebase origin master; else git pull --rebase origin main; fi";
      }
      {
        name = "gpskip";
        value = "git push -o ci.skip";
      }
      {
        name = "gs";
        value = "git status";
      }
      {
        name = "gst";
        value = "git stash";
      }
      {
        name = "gstd";
        value = "git stash drop";
      }
      {
        name = "gstp";
        value = "git stash pop";
      }
      {
        name = "gsurr";
        value = "git submodule update --remote --rebase";
      }
      {
        name = "gus";
        value = "git reset HEAD";
      }
    ]);
  };
}
