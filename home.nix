{ config, pkgs, lib, ... }:
let
  updateHM = pkgs.writeShellScriptBin "update-home-manager" ''

    echo "Updating flake"
    nix flake update --commit-lock-file --commit-lockfile-summary "chore(flake): Update $(date -I)"

    echo "Reloading home-manager config"
    home-manager switch --flake . --impure

    echo "Collecting garbage"
    nix-collect-garbage

    echo "Updating tealdeer cache"
    tldr --update

    echo "Updating nvim plugins"
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
  '';
in
{
  imports = [
    ./home-manager/homecfg.nix
  ];

  homecfg = {
    gui.enable = false;
    dev.enable = true;
    fun.enable = true;
    k8s.enable = true;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      tea = true;
      gh = true;
      glab = false;
    };
    nvim.enable = true;
    tmux.enable = true;
    tools.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [
    scrcpy
    sshfs
    unrar
    updateHM
    xclip
    yt-dlp
    ytfzf
  ];

  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "rh"; value = "/usr/bin/flatpak-spawn --host"; }
        { name = "rhs"; value = "/usr/bin/flatpak-spawn --host sudo -S"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
      ]
    );
  };
}
