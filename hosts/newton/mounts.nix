{ config, pkgs, ... }:
{
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
