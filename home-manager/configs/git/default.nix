{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg;
in
{
  imports = [
    ./tea.nix
    ./github.nix
    ./glab.nix
  ];

  options.homecfg.git.enable = lib.mkEnableOption "Manage git with home-manager";

  config = lib.mkIf (cfg.git.enable) {
    programs.git = {
      enable = cfg.git.enable;
    };

    programs.git.delta = {
      enable = cfg.git.enable;
    };

    xdg.configFile = {
      "git/config".source = ./gitconfig;
    };

    programs.zsh.oh-my-zsh.plugins = [
      "git"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "gcm"; value = "git commit -v -m"; }
        { name = "gcmld"; value = ''git checkout master && git pull && comm -12 <(git branch | sed "s/ *//g") <(git remote prune origin --dry-run | sed "s/^.*origin\///g") | xargs -I'{}' git branch -D {}''; }
        { name = "gdm"; value = "git diff --cached master"; }
        { name = "gfmm"; value = "git fetch origin && git merge origin/master"; }
        { name = "gprom"; value = "git pull --rebase origin master"; }
        { name = "gpskip"; value = "git push -o ci.skip"; }
        { name = "gs"; value = "git status"; }
        { name = "gus"; value = "git reset HEAD"; }
      ]
    );
  };
}
