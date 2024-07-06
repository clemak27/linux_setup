{ config, pkgs, ... }: {
  home = {
    username = "deck";
    homeDirectory = "/home/deck";
    stateVersion = "24.05";
    packages = [
      pkgs.dsda-doom
    ];
  };
  news.display = "silent";
  homecfg = {
    git.enable = true;
    tools.enable = true;
    zsh.enable = true;
  };
  services.syncthing.enable = true;
  programs.zsh = {
    shellAliases = builtins.listToAttrs (
      [
        { name = "hms"; value = "git -C /home/deck/Projects/linux_setup pull --rebase && home-manager switch --flake /home/deck/Projects/linux_setup"; }
      ]
    );

    initExtra = ''
      if [ -z "$NIX_PROFILES" ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi
      # export correct shell
      export SHELL="$HOME/.nix-profile/bin/zsh"
      export GIT_SSH="/usr/bin/ssh";
    '';
  };
}
