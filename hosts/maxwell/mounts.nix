{ config, pkgs, ... }:
{
  # mount additional HDDs

  fileSystems."/home/clemens/Games" = {
    device = "/dev/disk/by-uuid/67de20f1-9d79-42ba-aec1-2ff30faf5dd9";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  environment.systemPackages = [
    pkgs.nfs-utils
  ];

  # mount nfs volumes
  # fileSystems."/home/clemens/nfs/media" = {
  #   device = "192.168.178.100:/media";
  #   fsType = "nfs";
  #   options = [ "x-systemd.automount" "_netdev" "x-systemd.idle-timeout=60" "noauto" ];
  # };
}
