{ config, pkgs, ... }:
{
  config = {
    systemd.services.system-update.serviceConfig = {
      Type = "oneshot";
      ExecStart = ''nixos-rebuild switch --upgrade && nix-collect garbage'';
    };

    systemd.timers.system-update = {
      wantedBy = [ "timers.target" ];
      partOf = [ "system-update.service" ];
      timerConfig = {
        OnCalendar = [ "weekly" ];
        Persistent = true;
      };
    };
  };
}
