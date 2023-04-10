{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./mounts.nix
    ./sops.nix
    # ./wireguard.nix

    ./logitech_rgb.nix
  ];

  networking.hostName = "argentum";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/eed2c8ab-3333-4778-a710-153119bc260b";
    preLVM = true;
    allowDiscards = true;
  };

  system.stateVersion = "22.11";
}
