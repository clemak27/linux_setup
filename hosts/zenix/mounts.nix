{ config, pkgs, ... }:
{
  # mount additional HDDs
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/home/clemens/Games" = {
    device = "/dev/disk/by-uuid/67de20f1-9d79-42ba-aec1-2ff30faf5dd9";
    fsType = "ext4";
    options = [ "defaults" ];
  };

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
