{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix

    ./gpu.nix
    ./laptop.nix

    ../../modules/general.nix
    ../../modules/plasma.nix
    ../../modules/pipewire.nix
    ../../modules/gaming.nix
    ../../modules/virt-manager.nix
    ../../modules/container.nix

    <home-manager/nixos>
  ];

  networking.hostName = "xps15";
  networking.interfaces.wlp59s0.useDHCP = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/46b1e218-b716-4250-8fce-ab0b35f1a651";
    preLVM = true;
    allowDiscards = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.clemens = ./home.nix;

  system.stateVersion = "21.05";
}
