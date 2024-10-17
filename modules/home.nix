{ pkgs, ... }:
let
  cdp = pkgs.writeShellApplication {
    name = "cdp";
    runtimeInputs = with pkgs; [
      wezterm
      fd
      sd
      fzf
      gnugrep
      neovim
    ];
    text = /*bash*/ ''
      path=$(fd --type=d --hidden --no-ignore ".git" --exclude node_modules --exclude tmp --absolute-path "$HOME/Projects" | grep ".git/" | sd "/.git/" "" | fzf)
      if [ "$path" != "" ]; then
        pname=$(basename "$path")

        if [[ -n $WEZTERM_PANE ]]; then
          new_pane=$(wezterm cli spawn --cwd "$path")
          wezterm cli set-tab-title "$pname" --pane-id "$new_pane"
          wezterm cli activate-pane --pane-id "$new_pane"
          printf "nvim\n" | wezterm cli send-text --pane-id "$new_pane" --no-paste
        else
          cd "$path" || exit 1
        fi
      fi
    '';
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

  programs.firefox.enable = true;

  programs.mpv.enable = true;
  xdg.configFile."mpv/mpv.conf".source = ../dotfiles/mpv/mpv.conf;

  programs.wezterm.enable = true;
  xdg.configFile = {
    "wezterm/bindings.lua".source = ../dotfiles/wezterm/bindings.lua;
    "wezterm/opacity.lua".source = ../dotfiles/wezterm/opacity.lua;
    "wezterm/wezterm.lua".source = ../dotfiles/wezterm/wezterm.lua;
  };

  home.packages = with pkgs; [
    cdp
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
    initExtra = ''
      compdef _podman docker
    '';
  };


  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
