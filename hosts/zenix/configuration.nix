{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ./sops.nix

    ./gpu.nix
    ./hdds.nix
    ./logitech_rgb.nix

    ../../modules/general.nix
    ../../modules/gnome.nix
    ../../modules/pipewire.nix
    ../../modules/gaming.nix
    ../../modules/virt-manager.nix
    ../../modules/container.nix
    ../../modules/ssh.nix
    ../../modules/flatpak.nix

    <home-manager/nixos>
  ];

  networking.hostName = "zenix";
  networking.interfaces.enp27s0.useDHCP = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/ea64b075-abb6-475f-b4c9-6839f5907664";
    preLVM = true;
    allowDiscards = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.clemens = ./home.nix;

  system.stateVersion = "21.05";
}
