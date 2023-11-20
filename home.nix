{ pkgs, ... }:
let
  cdProject = pkgs.writeShellScriptBin "cdp" ''
    path=$(fd --type=d --hidden ".git" --exclude gitea-repos --absolute-path $HOME/Projects | grep ".git/" | sd "/.git/" "" | fzf)
    if [ "$path" != "" ]; then
      pname=$(basename $path)
      path="/home/clemens/Projects/$pname"

      if [[ ! -z $ZELLIJ ]]; then
        zellij action new-tab --cwd $path --name $pname --layout dev
      elif [[ ! -z $TMUX ]]; then
        tmux new-window -c $path -n $pname nvim \; split-window -v -l 13 -d -c $path
      else
        cd $path
      fi

    fi
  '';
  mpvBin = pkgs.writeShellScriptBin "mpv" ''
    flatpak run io.mpv.Mpv "$@"
  '';
  zjBar = "file:${pkgs.zjStatus}/bin/zjstatus.wasm";
  zjBarOptions = '' {
      format_left  "#[bg=#11111B] {mode}#[bg=#11111B] {tabs}"
      format_right ""
      format_space "#[bg=#11111B]"

      mode_normal        "#[bg=#11111B,fg=green,bold]NORMAL"
      mode_locked        "#[bg=#11111B,fg=red,bold] LOCKED"
      mode_resize        "#[bg=#11111B,fg=#fab387,bold] RESIZE"
      mode_pane          "#[bg=#11111B,fg=#fab387,bold] PANE"
      mode_tab           "#[bg=#11111B,fg=#fab387,bold] TAB"
      mode_scroll        "#[bg=#11111B,fg=#fab387,bold] SCROLL"
      mode_rename_tab    "#[bg=#11111B,fg=#fab387,bold] RENAME TAB"
      mode_rename_pane   "#[bg=#11111B,fg=#fab387,bold] RENAME PANE"
      mode_session       "#[bg=#11111B,fg=#fab387,bold] SESSION"
      mode_move          "#[bg=#11111B,fg=#fab387,bold] MOVE"

      tab_normal   "#[fg=#9399B2,bg=#11111B] {index}: {name} "
      tab_active   "#[fg=#cdd6f4,bg=#1E1E2E,bold] {index}: {name} "
    }
  '';
in
{
  imports = [
    ./kde
  ];

  home = {
    username = "clemens";
    homeDirectory = "/home/clemens";
    stateVersion = "23.05";
  };
  news.display = "silent";

  homecfg = {
    dev.enable = true;
    fun.enable = true;
    k8s.enable = true;
    k8s.k9s = true;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      ssh_key = builtins.readFile /home/clemens/.ssh/id_ed25519.pub;
      gh = true;
    };
    nvim.enable = true;
    tmux.enable = false;
    tools.enable = true;
    todo.enable = true;
    zsh.enable = true;
    zellij.enable = true;
    zellij.bar = zjBar;
    zellij.barOptions = zjBarOptions;
    helix.enable = false;
  };

  xdg.configFile = {
    "zellij/layouts/notes.kdl".text = ''
      layout {
          pane size=1 borderless=true {
            plugin location="${zjBar}" ${zjBarOptions}
          }
          pane split_direction="vertical" {
            pane {
              cwd "~/Notes"
              name "nvim"
            }
            pane {
              cwd "~/Notes"
              name "tasks"
              command "tdt"
              size "40%"
            }
          }
      }
    '';
  };

  home.packages = [
    pkgs.wl-clipboard
    pkgs.wl-clipboard-x11

    pkgs.scrcpy
    pkgs.unrar
    pkgs.yt-dlp
    pkgs.ytfzf

    mpvBin
    cdProject

    pkgs.tdtPkgs.tdt
  ];

  home.file = {
    ".local/bin/mpv".source = "${mpvBin}/bin/mpv";
  };

  services.syncthing.enable = true;

  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "hms"; value = "home-manager switch --impure --flake /home/clemens/Projects/linux_setup"; }
        { name = "hmsl"; value = "home-manager switch --impure --flake /home/clemens/Projects/linux_setup --override-input homecfg 'path:/home/clemens/Projects/homecfg'"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
        { name = "zjNotes"; value = "zellij action new-tab --name Notes --layout notes"; }
      ]
    );

    initExtra = ''
      if [ -z "$NIX_PROFILES" ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      # export correct shell
      export SHELL="$HOME/.nix-profile/bin/zsh"

      # nvim copy-paste bugfix
      export LANG='en_US.UTF-8'

      export GIT_SSH="/usr/bin/ssh";
      # export DOCKER_HOST=unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')

      # autostart tmux
      if command -v tmux &> /dev/null; then
        if tmux info &> /dev/null; then
          tmux start-server
        fi
        if [ ! "$TMUX" ]; then
          grep -q "main:.*(attached)" <(tmux ls)
          if [ $? = 1 ]; then
            tmux new-session -A -D -s main -c ~/Projects -n projects
          fi
        fi
      fi

      if command -v zellij &> /dev/null; then
        if [ ! "$ZELLIJ" ]; then
          grep -q "main.*EXITED" <(zellij ls)
          mainExited=$?
          grep -q "main" <(zellij ls)
          mainExists=$?

          if [ $mainExited = 0 ]; then
            zellij attach main
          elif [ $mainExited = 1 ] && [ $mainExists = 1 ]; then
            zellij -s main
          fi
        fi
      fi
    '';
  };

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
