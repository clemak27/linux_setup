{ config, pkgs, ... }:
{
  # hdds
  fileSystems."/home/clemens/data" = {
    device = "/dev/disk/by-uuid/886f6cde-4ed8-414d-9260-ee5ae4c75786";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."/home/clemens/data_bu" = {
    device = "/dev/disk/by-uuid/03bfac2e-27ba-4a6e-a0a3-1dada4aca0f1";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  # bind mount hdds to provide them with nfs
  fileSystems."/nfs/archive" = {
    device = "/home/clemens/data/archive";
    options = [ "bind" ];
  };

  fileSystems."/nfs/videos" = {
    device = "/home/clemens/data/videos";
    options = [ "bind" ];
  };

  # nfs (potentially sudo mkdir /nfs needed?)
  services.nfs.server = {
    enable = true;
    exports = ''
      /nfs          192.168.0.0/24(rw,fsid=0,no_subtree_check)
      /nfs/archive  192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
      /nfs/videos   192.168.0.0/24(rw,nohide,insecure,no_subtree_check)
    '';
  };

}
