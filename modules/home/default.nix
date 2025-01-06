{ pkgs, ... }:
{
  imports = [
    ../kde/config.nix
    ./wezterm
  ];

  homecfg = {
    dev.enable = true;
    k8s.enable = true;
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
  xdg.configFile."mpv/mpv.conf".text = ''
    autofit-larger=40%x40%
    ytdl-format="bestvideo[height<=?1080]+bestaudio/best"
    no-keepaspect-window
    volume=80
  '';

  home.packages = with pkgs; [
    wl-clipboard

    feishin

    podman-compose
    scrcpy
    unrar
    yt-dlp
  ];

  programs.zsh = {
    shellAliases = builtins.listToAttrs [
      { name = "hcsl"; value = "sudo nixos-rebuild test --impure --flake /home/clemens/Projects/linux_setup --override-input homecfg 'path:/home/clemens/Projects/homecfg'"; }
      { name = "youtube-dl"; value = "yt-dlp"; }
      { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
    ];

    initExtra = ''
      compdef _podman docker
      export LC_ALL=en_US.UTF-8
    '';
  };


  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
