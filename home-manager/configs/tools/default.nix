{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tools;
  stable = import <nixos-stable> { };
in
{
  options.homecfg.tools.enable = lib.mkEnableOption "Manage command line tools with homecfg";

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      bat
      bottom
      curl
      exa
      fd
      hyperfine
      jq
      stable.pgcli
      ranger
      ripgrep
      sd
      tealdeer
      timewarrior
      todo-txt-cli
      ueberzug
    ] ++ lib.optionals stdenv.isLinux [
      android-tools
    ];

    home.file.".oh-my-zsh/custom/plugins/timewarrior".source =
      builtins.fetchGit {
        url = "https://github.com/svenXY/timewarrior.git";
        ref = "master";
      };

    home.file.".config/ranger/plugins/ranger_devicons".source =
      builtins.fetchGit {
        url = "https://github.com/alexanderjeurissen/ranger_devicons";
        ref = "main";
      };

    programs.fzf = {
      enable = true;
      defaultCommand = "rg --files --hidden";
      defaultOptions = [ "--height=50%" "--layout=reverse" "--info=inline" "--border=sharp" "--margin=1" "--padding=1" ];
    };

    programs.zsh.oh-my-zsh.plugins = [
      "fd"
      "fzf"
      "ripgrep"
    ];

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "cat"; value = "bat"; }
        { name = "ls"; value = "exa --icons"; }
        { name = "lsa"; value = "exa --icons -hal"; }
        { name = "todo"; value = "todo.sh"; }
      ]
    );

    systemd.user.services.tealdeer-update-cache.Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.zsh}/bin/zsh -c "tldr --update"
      '';
    };

    systemd.user.timers.tealdeer-update-cache = {
      Install.WantedBy = [ "timers.target" ];
      Unit.PartOf = [ "tealdeer-update-cache.service" ];
      Timer.OnCalendar = [ "weekly" ];
    };

    home.file = {
      ".todo/config".source = ./todo/todo.cfg;
      ".local/bin/rfv".source = ./rfv;
    };

    xdg.configFile = {
      "ranger/rc.conf".source = ./ranger/ranger.rc;
      "ranger/commands.py".source = ./ranger/ranger.commands;
      "bat/config".source = ./bat/config;
    };
  };
}
