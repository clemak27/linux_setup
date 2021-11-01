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
    ./logitech_rgb.nix

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
    device = "/dev/disk/by-uuid/ea64b075-abb6-475f-b4c9-6839f5907664";
    preLVM = true;
    allowDiscards = true;
  };

  networking.hostName = "zenix";
  networking.interfaces.enp27s0.useDHCP = true;

  services.printing.enable = true;

  # mount additional HDDs
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/home/clemens/Games" = {
    device = "/dev/disk/by-uuid/5E2CCEED67691F72";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=1000" "user" "exec" "umask=000" ];
  };

  fileSystems."/home/clemens/Archive" = {
    device = "/dev/disk/by-uuid/48764082764072AC";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=1000" "user" "exec" "umask=000" ];
  };
  fileSystems."/home/clemens/Videos" = {
    device = "/dev/disk/by-uuid/ACE41486E4145544";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=1000" "user" "exec" "umask=000" ];
  };
  fileSystems."/home/clemens/.ssd_games" = {
    device = "/dev/disk/by-uuid/692ccaac-ce21-45aa-bdd4-7d7ea5b2e497";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  system.stateVersion = "21.05";
}
