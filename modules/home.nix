{ config, pkgs, lib, ... }:
{
  imports = [
    ./gnome/customization.nix
  ];

  homecfg = {
    dev.enable = true;
    fun.enable = true;
    k8s.enable = true;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      ssh_key = builtins.readFile /home/clemens/.ssh/id_ed25519.pub;
      gh = true;
    };
    nvim.enable = true;
    tmux.enable = true;
    tools.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [
    celluloid
    gimp
    helvum
    kid3
    libreoffice
    sonixd
    thunderbird

    wl-clipboard
    wl-clipboard-x11

    scrcpy
    unrar
    yt-dlp
    ytfzf
  ];

  programs.firefox.enable = true;
  programs.wezterm.enable = true;

  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "hcsl"; value = "sudo nixos-rebuild test  --impure --flake /home/clemens/Projects/linux_setup --override-input homecfg 'path:/home/clemens/Projects/homecfg'"; }
        { name = "mpv"; value = "/usr/bin/flatpak-spawn --host flatpak run io.mpv.Mpv"; }
        { name = "tam"; value = "tmux new-session -A -D -s main -c ~/Projects -n projects"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
      ]
    );

    initExtra = ''
      # autostart tmux
      if tmux info &> /dev/null; then
        tmux start-server
      fi
      if [ ! "$TMUX" ]; then
        tmux new-session -A -D -s main -c ~/Projects -n projects
      fi
    '';
  };

  xdg.configFile = {
    "nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "/home/clemens/Projects/linux_setup/dotfiles/lazy-lock.json";
  };

  home.file.".wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/clemens/Projects/linux_setup/dotfiles/wezterm.lua";

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
