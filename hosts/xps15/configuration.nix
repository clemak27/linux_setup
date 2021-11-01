# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
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
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/46b1e218-b716-4250-8fce-ab0b35f1a651";
    preLVM = true;
    allowDiscards = true;
  };

  networking.hostName = "xps15";
  networking.interfaces.wlp59s0.useDHCP = true;

  system.stateVersion = "21.05";
}

