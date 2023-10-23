{ config, pkgs, lib, ... }:
let
  cdProject = pkgs.writeShellScriptBin "cdp" ''
    path=$(fd --type=d --hidden ".git" --exclude gitea-repos --absolute-path $HOME/Projects | grep ".git/" | sd "/.git/" "" | fzf)
    if [ "$path" != "" ]; then
      pname=$(basename $path)

      if [[ ! -z $ZELLIJ ]]; then
        zellij action new-tab --cwd $path --name $pname --layout dev
      elif [[ ! -z $TMUX ]]; then
        tmux new-window -c $path -n $pname nvim \; split-window -v -l 13 -d -c $path
      else
        cd $path
      fi

    fi
  '';
in
{
  imports = [
    ./gnome/customization.nix
  ];

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
    zsh.enable = true;
    zellij.enable = true;
    zellij.bar = "file:~/.config/zellij/custom-zellij-bar.wasm";
    helix.enable = false;
    # helix.package = pkgs.helixPkgs.helix;
  };


  xdg.configFile."zellij/custom-zellij-bar.wasm".source = "${pkgs.czb.custom-zellij-bar}/bin/custom-zellij-bar.wasm";

  home.packages = [
    pkgs.celluloid
    pkgs.gimp
    pkgs.helvum
    pkgs.kid3
    pkgs.libreoffice
    pkgs.signal-desktop
    pkgs.sonixd
    pkgs.thunderbird
    pkgs.webcord-vencord

    pkgs.wl-clipboard
    pkgs.wl-clipboard-x11

    pkgs.scrcpy
    pkgs.unrar
    pkgs.yt-dlp
    pkgs.ytfzf
    pkgs.tdtPkgs.tdt
    cdProject
  ];

  programs.firefox.enable = true;
  programs.wezterm.enable = true;
  programs.mpv.enable = true;

  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "hcsl"; value = "sudo nixos-rebuild test  --impure --flake /home/clemens/Projects/linux_setup --override-input homecfg 'path:/home/clemens/Projects/homecfg'"; }
        { name = "tam"; value = "tmux new-session -A -D -s main -c ~/Projects -n projects"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
      ]
    );

    initExtra = ''
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
          if [ ! $(zellij ls | grep main) ]; then
            zellij -s main
          fi
        fi
      fi
    '';
  };

  home.file.".wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/clemens/Projects/linux_setup/dotfiles/wezterm.lua";

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
