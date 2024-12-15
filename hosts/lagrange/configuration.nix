{ pkgs, lib, ... }:
{
  imports = [
    ./disko.nix
    ./gpu.nix
    ./hardware-configuration.nix
    # ./wireguard.nix
  ];

  networking.hostName = "lagrange";

  services.xserver.xkb.layout = "de";

  environment.systemPackages = with pkgs; [
    nfs-utils
    piper
  ];

  # devices
  services.ratbagd.enable = true;
  services.hardware.openrgb.enable = true;
  hardware.xone.enable = true;

  # mounts
  # fileSystems = {
  #   "/home/clemens/Games" = {
  #     device = "/dev/disk/by-uuid/b43b6214-df60-4adc-a4a7-017cd48f0df9";
  #     fsType = "btrfs";
  #     options = [ "compress=zstd" ];
  #   };
  # };

  # boot.loader.systemd-boot.enable = lib.mkForce false;
  #
  # boot.lanzaboote = {
  #   enable = true;
  #   pkiBundle = "/var/lib/sbctl";
  # };

  system.stateVersion = "24.11";
}
