{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ./sops.nix
    ./mounts.nix

    ./gpu.nix
    ./laptop.nix

    ../../modules/general.nix
    ../../modules/gnome
    ../../modules/pipewire.nix
    ../../modules/virt-manager.nix
    ../../modules/container.nix
    ../../modules/ssh.nix
    ../../modules/flatpak.nix
  ];

  networking.hostName = "silfur";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/61091175-276e-4591-ba9c-bc0d95c1ed8c";
    preLVM = true;
    allowDiscards = true;
  };

  system.stateVersion = "22.11";
}
