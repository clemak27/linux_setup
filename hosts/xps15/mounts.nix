{ config, pkgs, ... }:
{
  # mount nfs volumes
  fileSystems."/home/clemens/Archive" = {
    device = "192.168.0.30:/archive";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/home/clemens/Videos" = {
    device = "192.168.0.30:/videos";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
}
