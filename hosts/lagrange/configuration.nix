{ pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./gpu.nix
    ./hardware-configuration.nix
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

  # mounts
  # fileSystems = {
  #   "/home/clemens/Games" = {
  #     device = "/dev/disk/by-uuid/1d007512-92c1-40ba-8863-f50589b88437";
  #     fsType = "btrfs";
  #     options = [ "compress=zstd" ];
  #   };
  # };

  system.stateVersion = "24.11";
}
