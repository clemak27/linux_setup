{ pkgs, lib, ... }:
{
  imports = [
    ./disko.nix
    ./gpu.nix
    ./hardware-configuration.nix
    ./wireguard.nix
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

  system.stateVersion = "24.11";
}
