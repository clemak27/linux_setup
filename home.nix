{ config, pkgs, lib, ... }:
let
  updateHM = pkgs.writeShellScriptBin "update-homecfg" ''
    set -eo pipefail

    echo "Updating flake"
    nix flake update
    git add flake.nix flake.lock
    git commit -m "chore(flake): Update $(date -I)"

    echo "Reloading home-manager config"
    home-manager switch --flake '.?submodules=1' --impure

    echo "Collecting garbage"
    nix-collect-garbage

    echo "Updating nvim plugins"
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

    # start update, cause it runs async after PackerSync and usually gets interrupted
    echo "Updating nvim-treesitter"
    nvim --headless -c 'TSUpdateSync' -c 'q!'
  '';
in
{
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
    unrar
    updateHM
    xclip
    yt-dlp
    ytfzf
  ];

  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "docker"; value = "/usr/bin/flatpak-spawn --host podman"; }
        { name = "hms"; value = "home-manager switch --flake '.?submodules=1' --impure"; }
        { name = "hmsl"; value = "home-manager switch --flake . --impure --override-input homecfg 'path:/home/clemens/Projects/homecfg'"; }
        { name = "mpv"; value = "/usr/bin/flatpak-spawn --host flatpak run io.mpv.Mpv"; }
        { name = "podman"; value = "/usr/bin/flatpak-spawn --host podman"; }
        { name = "prcwd"; value = "/usr/bin/flatpak-spawn --host podman run --interactive --rm --security-opt label=disable --volume $(pwd):/pwd --workdir /pwd"; }
        { name = "rh"; value = "/usr/bin/flatpak-spawn --host"; }
        { name = "rhs"; value = "/usr/bin/flatpak-spawn --host sudo -S"; }
        { name = "tam"; value = "tmux new-session -A -D -s main -c ~/Projects -n projects"; }
        { name = "youtube-dl"; value = "yt-dlp"; }
        { name = "youtube-dl-music"; value = "yt-dlp --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
      ]
    );

    initExtra = ''
      # nix home-manager init
      . $HOME/.nix-profile/etc/profile.d/nix.sh
      export GIT_SSH=/usr/bin/ssh

      # autostart tmux
      if tmux info &> /dev/null; then 
        tmux start-server
      fi
      if [ ! "$TMUX" ]; then
        tmux new-session -A -D -s main -c ~/Projects -n projects
      fi
    '';
  };

  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
}
