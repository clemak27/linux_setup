{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../modules/general.nix
    ../../modules/gnome
    ../../modules/pipewire.nix
    ../../modules/container.nix
    ../../modules/flatpak.nix
  ];

  networking.hostName = "virtual";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/ea64b075-abb6-475f-b4c9-6839f5907664";
    preLVM = true;
    allowDiscards = true;
  };

  system.stateVersion = "22.11";
}
