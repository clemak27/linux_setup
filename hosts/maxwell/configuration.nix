{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./mounts.nix

    ./devices.nix
  ];

  networking.hostName = "maxwell";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/9faaddbe-9604-4f31-b9c5-fd6265e1ea46";
    preLVM = true;
    allowDiscards = true;
  };

  services.xserver.xkb.layout = "us";

  system.stateVersion = "24.05";
}
