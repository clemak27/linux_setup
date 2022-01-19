{ config, pkgs, ... }:
let
  duckDnsUpdate = builtins.readFile "/run/secrets/duckdns_url";
in
{
  # systemd.services.wg-workaround.serviceConfig = {
  #   Type = "oneshot";
  #   ExecStart = ''systemctl restart wg-quick-wg0'';
  # };

  # systemd.timers.wg-workaround = {
  #   wantedBy = [ "timers.target" ];
  #   partOf = [ "wg-workaround.service" ];
  #   timerConfig = {
  #     OnCalendar = [ "*-*-* 16:45:00" ];
  #     Persistent = true;
  #   };
  # };

  systemd.services.mp3gain-update.serviceConfig = {
    User = "clemens";
    Type = "oneshot";
    ExecStart = ''${pkgs.zsh}/bin/zsh -c "/home/clemens/mp3gain-update.sh"'';
  };

  systemd.services.mp3gain-update.path = [
    pkgs.tree
    pkgs.mp3gain
    pkgs.fd
    pkgs.diffutils
    pkgs.curl
  ];

  systemd.timers.mp3gain-update = {
    wantedBy = [ "timers.target" ];
    partOf = [ "mp3gain-update.service" ];
    timerConfig = {
      OnCalendar = [ "*-*-* *:00:00" "*-*-* *:15:00" "*-*-* *:30:00" "*-*-* *:45:00" ];
      Persistent = true;
    };
  };

  systemd.services.duckdns-update.serviceConfig = {
    User = "clemens";
    Type = "oneshot";
    ExecStart = ''${pkgs.curl}/bin/curl --url "${duckDnsUpdate}"'';
  };

  systemd.services.duckdns-update.path = [
    pkgs.curl
  ];

  systemd.timers.duckdns-update = {
    wantedBy = [ "timers.target" ];
    partOf = [ "duckdns-update.service" ];
    timerConfig = {
      OnCalendar = [ "*-*-* *:00:00" "*-*-* *:15:00" "*-*-* *:30:00" "*-*-* *:45:00" ];
      Persistent = true;
    };
  };
}
