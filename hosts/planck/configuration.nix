{
  config,
  lib,
  pkgs,
  ...
}:
let
  jetBrainsMono = pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip";
    hash = "sha256-M3+MvmKqiOYelJkujuqAsalxIBxb5+MBJ4uoNGV+1Fg=";
    stripRoot = false;
  };
in
{
  environment.packages = with pkgs; [
    vim
    wget
    curl
    git
    zsh
  ];
  system.stateVersion = "23.11";

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "Europe/Vienna";

  terminal.colors = {
    background = "#121212";
    foreground = "#cdd6f4";
    cursor = "#cdd6f4";
    color0 = "#45475a";
    color8 = "#585b70";
    color1 = "#f38ba8";
    color9 = "#f38ba8";
    color2 = "#a6e3a1";
    color10 = "#a6e3a1";
    color3 = "#f9e2af";
    color11 = "#f9e2af";
    color4 = "#89b4fa";
    color12 = "#89b4fa";
    color5 = "#f5c2e7";
    color13 = "#f5c2e7";
    color6 = "#94e2d5";
    color14 = "#94e2d5";
    color7 = "#bac2de";
    color15 = "#a6adc8";
  };
  terminal.font = "${jetBrainsMono}/JetBrainsMonoNerdFont-Regular.ttf";
  user.shell = "${pkgs.zsh}/bin/zsh";

  home-manager = {
    useGlobalPkgs = true;

    config =
      {
        config,
        lib,
        pkgs,
        ...
      }:

      {
        # Read the changelog before changing this value
        home.stateVersion = "23.11";
        home.enableNixpkgsReleaseCheck = false;

        programs.zsh = {
          enable = true;
          localVariables = {
            PROMPT_EOL_MARK = "";
            ZSH_DISABLE_COMPFIX = false;
          };
          history = {
            size = 50000;
            save = 25000;
          };
          oh-my-zsh = {
            enable = true;
            plugins = [
              "extract"
              "rsync"
              "git"
            ];
            custom = "$HOME/.oh-my-zsh/custom";
          };
          shellAliases = builtins.listToAttrs ([
            {
              name = "cd..";
              value = "cd ..";
            }
            {
              name = "clear";
              value = "printf '\\33c\\e[3J'";
            }
            {
              name = "q";
              value = "exit";
            }
            {
              name = "hms";
              value = "git -C $HOME/Projects/linux_setup pull --rebase && nix-on-droid switch --flake $HOME/Projects/linux_setup";
            }
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

          sessionVariables = {
            PATH = "$PATH:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.local/bin:$HOME/.local/bin/npm/bin:$HOME/.local/share/nvim/mason/bin";
          };

          initExtra = builtins.concatStringsSep "\n" ([
            # no beeps
            "unsetopt beep"
            # don't save duplicates in zsh_history
            "setopt HIST_SAVE_NO_DUPS"
            # https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
            "source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
          ]);
        };

        home.file.".oh-my-zsh/custom/plugins/zsh-syntax-highlighting".source = builtins.fetchGit {
          url = "https://github.com/zsh-users/zsh-syntax-highlighting.git";
          ref = "master";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
        };

        programs.dircolors.enable = true;

        programs.starship = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            add_newline = false;
            line_break = {
              disabled = true;
            };
          };
        };

        home.packages = with pkgs; [
          zsh-completions
          openssh
        ];
      };
  };
}
