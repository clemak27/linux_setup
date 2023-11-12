{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./mounts.nix
    ./wireguard.nix

    ./gpu.nix
    ./laptop.nix
  ];

  networking.hostName = "silfur";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/44ef95bc-238e-419c-8ffe-bcb7088da0f7";
    preLVM = true;
    allowDiscards = true;
  };

  system.stateVersion = "22.11";
}
