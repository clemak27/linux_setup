{ config, pkgs, ... }:
let
  duckDnsUpdate = builtins.readFile "/run/secrets/duckdns_url";
in
{
  systemd.services.mp3gain-update = {
    path = [
      pkgs.tree
      pkgs.diffutils
      pkgs.mp3gain
      pkgs.fd
      pkgs.curl
    ];
    serviceConfig = {
      User = "clemens";
      Type = "oneshot";
      ExecStart = ''${pkgs.zsh}/bin/zsh -c "/home/clemens/mp3gain-update.sh"'';
    };
  };

  systemd.timers.mp3gain-update = {
    wantedBy = [ "timers.target" ];
    partOf = [ "mp3gain-update.service" ];
    timerConfig = {
      OnCalendar = [ "*-*-* *:00:00" "*-*-* *:15:00" "*-*-* *:30:00" "*-*-* *:45:00" ];
      Persistent = true;
    };
  };

  systemd.services.duckdns-update = {
    path = [
      pkgs.curl
    ];
    serviceConfig = {
      User = "clemens";
      Type = "oneshot";
      ExecStart = ''${pkgs.curl}/bin/curl --url "${duckDnsUpdate}"'';
    };
  };

  systemd.timers.duckdns-update = {
    wantedBy = [ "timers.target" ];
    partOf = [ "duckdns-update.service" ];
    timerConfig = {
      OnCalendar = [ "*-*-* *:00:00" "*-*-* *:15:00" "*-*-* *:30:00" "*-*-* *:45:00" ];
      Persistent = true;
    };
  };

  systemd.services.gitops-update = {
    path = [
      pkgs.git
    ];
    serviceConfig = {
      User = "clemens";
      Type = "oneshot";
      ExecStart = ''${pkgs.git}/bin/git -C /home/clemens/linux_setup pull '';
    };
  };

  systemd.timers.gitops-update = {
    wantedBy = [ "timers.target" ];
    partOf = [ "gitops-update.service" ];
    timerConfig = {
      OnCalendar = [ "*-*-* *:*:00" ];
      Persistent = true;
    };
  };

  systemd.services.gitops-upgrade = {
    path = [
      pkgs.git
      pkgs.curl
      pkgs.tree
      pkgs.diffutils
      pkgs.nix_2_6
      pkgs.nixos-rebuild
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''${pkgs.zsh}/bin/zsh -c "/home/clemens/gitops-upgrade.sh"'';
    };
  };

  systemd.timers.gitops-upgrade = {
    wantedBy = [ "timers.target" ];
    partOf = [ "gitops-upgrade.service" ];
    timerConfig = {
      OnCalendar = [ "*-*-* *:*:05" ];
      Persistent = true;
    };
  };


}
