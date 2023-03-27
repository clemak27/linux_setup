{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./wireguard.nix
    ./sops.nix
    ./mounts.nix

    ./logitech_rgb.nix

    ../../modules/general.nix
    ../../modules/gnome
    ../../modules/pipewire.nix
    ../../modules/virt-manager.nix
    ../../modules/container.nix
    ../../modules/ssh.nix
    ../../modules/flatpak.nix
  ];

  networking.hostName = "argentum";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/eed2c8ab-3333-4778-a710-153119bc260b";
    preLVM = true;
    allowDiscards = true;
  };

  system.stateVersion = "22.11";
}
