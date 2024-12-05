{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "maxwell";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/9faaddbe-9604-4f31-b9c5-fd6265e1ea46";
    preLVM = true;
    allowDiscards = true;
  };

  services.xserver.xkb.layout = "us";

  environment.systemPackages = with pkgs; [
    nfs-utils
    piper
  ];

  # devices
  services.ratbagd.enable = true;
  services.hardware.openrgb.enable = true;
  hardware.keyboard.qmk.enable = true;

  # mounts
  fileSystems = {
    "/home/clemens/Games" = {
      device = "/dev/disk/by-uuid/1d007512-92c1-40ba-8863-f50589b88437";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };

    # "/home/clemens/nfs/media" = {
    #   device = "192.168.178.100:/media";
    #   fsType = "nfs";
    #   options = [ "x-systemd.automount" "_netdev" "x-systemd.idle-timeout=60" "noauto" ];
    # };
  };

  system.stateVersion = "24.05";
}
