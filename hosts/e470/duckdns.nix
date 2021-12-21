{ config, lib, pkgs, ... }:
let
  duckDnsUpdate = builtins.readFile "/run/secrets/duckdns_url";
in
{
  config = {
    # somehow, it didn't start automatically?
    # systemctl --user enable duckdns-update.timer
    # systemctl --user start duckdns-update.timer
    systemd.user.services.duckdns-update.Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.curl}/bin/curl --url "${duckDnsUpdate}"
      '';
    };

    systemd.user.timers.duckdns-update = {
      Install.WantedBy = [ "timers.target" ];
      Unit.PartOf = [ "duckdns-update.service" ];
      Timer.OnCalendar = [ "*-*-* *:00:*" "*-*-* *:15:*" "*-*-* *:30:*" "*-*-* *:45:*" ];
      Timer.Persistent = true;
    };
  };
}
