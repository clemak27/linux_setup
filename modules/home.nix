{ config, pkgs, ... }:
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

  programs.firefox.enable = true;

  programs.mpv.enable = true;
  xdg.configFile."mpv/mpv.conf".source = ../dotfiles/mpv/mpv.conf;

  programs.wezterm.enable = true;
  xdg.configFile."wezterm/wezterm.lua".source = ../dotfiles/wezterm/wezterm.lua;
  xdg.configFile."wezterm/bindings.lua".source = ../dotfiles/wezterm/bindings.lua;
  home.file.".local/bin/cdp".source = ../dotfiles/wezterm/cdp;

  home.packages = with pkgs; [
    wl-clipboard

    calibre
    feishin
    gimp
    helvum
    kid3
    libreoffice
    signal-desktop
    vesktop

    podman-compose
    scrcpy
    unrar
    yt-dlp
  ];

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
