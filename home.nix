{ config, pkgs, lib, ... }:
let
  upgradeHM = pkgs.writeShellScriptBin "home-manager-upgrade" ''
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
  updateHM = pkgs.writeShellScriptBin "home-manager-update" ''
    home-manager switch --flake '.?submodules=1' --impure
  '';
in
{
  imports = [
    ./home-manager/homecfg.nix
  ];

  homecfg = {
    dev.enable = true;
    fun.enable = true;
    k8s.enable = true;
    git = {
      enable = true;
      user = "clemak27";
      email = "clemak27@mailbox.org";
      ssh_key = builtins.readFile ~/.ssh/id_ed25519.pub;
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
    upgradeHM
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
        { name = "mpv"; value = "/usr/bin/flatpak-spawn --host flatpak run io.mpv.Mpv"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
      ]
    );
  };

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
