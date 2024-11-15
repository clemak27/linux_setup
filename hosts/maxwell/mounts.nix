{ pkgs, ... }:
{
  # mount additional HDDs

  fileSystems."/home/clemens/Games" = {
    device = "/dev/disk/by-uuid/1d007512-92c1-40ba-8863-f50589b88437";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
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
