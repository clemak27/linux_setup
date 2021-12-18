{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tools;
in
{
  config = lib.mkIf (cfg.enable) {
    systemd.user.services.tealdeer-update-cache.Service = {
      Type = "oneshot";
      ExecStartPre = ''
        ${pkgs.zsh}/bin/zsh -c "notify-send 'Updating tealdeer-cache' 'Starting...' --icon=dialog-information"
      '';
      ExecStart = ''
        ${pkgs.zsh}/bin/zsh -c "tldr --update"
      '';
      ExecStartPost = ''
        ${pkgs.zsh}/bin/zsh -c "notify-send 'Updating tealdeer-cache' 'Done!' --icon=dialog-information"
      '';
    };

    systemd.user.timers.tealdeer-update-cache = {
      Install.WantedBy = [ "timers.target" ];
      Unit.PartOf = [ "tealdeer-update-cache.service" ];
      Timer.OnCalendar = [ "*-*-* *:15:00" ];
      Timer.Persistent = true;
    };
  };
}
