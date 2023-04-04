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
    device = "/dev/disk/by-uuid/44ef95bc-238e-419c-8ffe-bcb7088da0f7";
    preLVM = true;
    allowDiscards = true;
  };

  system.stateVersion = "22.11";
}
