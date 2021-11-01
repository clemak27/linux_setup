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

  networking.hostName = "zenix";
  networking.interfaces.enp27s0.useDHCP = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/ea64b075-abb6-475f-b4c9-6839f5907664";
    preLVM = true;
    allowDiscards = true;
  };

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
