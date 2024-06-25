{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nfs-utils
  ];

  # mount nfs volumes
  # fileSystems."/home/clemens/Archive" = {
  #   device = "192.168.0.30:/archive";
  #   fsType = "nfs";
  #   options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  # };
}
