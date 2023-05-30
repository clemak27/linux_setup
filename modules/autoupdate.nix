{ config, pkgs, ... }:
{
  systemd.services.autoupdate = {
    description = "NixOS Autoupdate Service";
    wantedBy = [ "multi-user.target" ];
    path = [
      pkgs.busybox
      pkgs.coreutils
      pkgs.flatpak
      pkgs.git
      pkgs.home-manager
      pkgs.jq
      pkgs.libnotify
      pkgs.neovim
      pkgs.openssh
    ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash /home/clemens/Projects/linux_setup/modules/autoupdate.sh";
      Type = "oneshot";
      User = "clemens";
      Group = "users";
      Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
    };
  };
}
