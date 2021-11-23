{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tools;
in
{
  config = lib.mkIf (cfg.enable && pkgs.stdenv.isLinux) {
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
      Timer.Persistent = true;
    };
  };
}
