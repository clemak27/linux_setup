{ pkgs, ... }:
let
  nixDsda = pkgs.writeShellApplication {
    name = "dsda-doom";
    runtimeInputs = with pkgs; [
      nixgl.nixGLDefault
      dsda-doom
    ];
    text = ''
      nixGL dsda-doom "$@"
    '';
  };
in
{
  imports = [
    ../../modules/home
  ];

  home = {
    username = "deck";
    homeDirectory = "/home/deck";
    stateVersion = "24.05";
    packages = [
      nixDsda
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
    shellAliases = builtins.listToAttrs ([
      {
        name = "hms";
        value = "git -C /home/deck/Projects/linux_setup pull --rebase && home-manager switch --flake /home/deck/Projects/linux_setup --impure";
      }
    ]);

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
