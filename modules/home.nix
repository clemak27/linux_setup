{ config, pkgs, ... }:
let
  mpvUI = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/cyl0/ModernX/main/modernx.lua";
    hash = "sha256-Vfd6bWu8z7RqB8HzuKctxM9/AHAN7/P4KHQ4IRXGx4Y=";
  };
  mpvFont = pkgs.fetchzip {
    url = "https://github.com/zavoloklom/material-design-iconic-font/releases/download/2.2.0/material-design-iconic-font.zip";
    hash = "sha256-xYoJjzxnjnCXZES7UVhNsk3T9MazK1KlNFzcTBsWv+M=";
    stripRoot = false;
  };
in
{
  imports = [
    ./gnome/customization.nix
  ];

  homecfg = {
    dev.enable = true;
    fun.enable = true;
    k8s.enable = true;
    k8s.k9s = false;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      ssh_key = builtins.readFile /home/clemens/.ssh/id_ed25519.pub;
      gh = true;
    };
    nvim.enable = true;
    nvim.transparent = true;
    tools.enable = true;
    zsh.enable = true;
  };

  services.syncthing.enable = true;

  programs.mpv.enable = true;
  xdg.configFile."mpv/mpv.conf".source = ../dotfiles/mpv/mpv.conf;
  xdg.configFile."mpv/scripts/modernx.lua".source = "${mpvUI}";
  home.file.".local/share/fonts/Material-Design-Iconic-Font.ttf".source = config.lib.file.mkOutOfStoreSymlink "${mpvFont}/fonts/Material-Design-Iconic-Font.ttf";

  programs.wezterm.enable = true;
  xdg.configFile."wezterm/wezterm.lua".source = ../dotfiles/wezterm/wezterm.lua;
  xdg.configFile."wezterm/bindings.lua".source = ../dotfiles/wezterm/bindings.lua;
  home.file.".local/bin/cdp".source = ../dotfiles/wezterm/cdp;

  home.packages = [
    pkgs.feishin
    pkgs.gimp
    pkgs.helvum
    pkgs.kid3
    pkgs.libreoffice
    pkgs.signal-desktop
    pkgs.vesktop

    pkgs.wl-clipboard
    pkgs.wl-clipboard-x11

    pkgs.scrcpy
    pkgs.unrar
    pkgs.yt-dlp
    pkgs.ytfzf
  ];

  programs.firefox.enable = true;

  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "hcsl"; value = "sudo nixos-rebuild test  --impure --flake /home/clemens/Projects/linux_setup --override-input homecfg 'path:/home/clemens/Projects/homecfg'"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
      ]
    );
  };


  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
