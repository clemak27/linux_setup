{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ./sops.nix
    ./mounts.nix

    ./gpu.nix
    ./laptop.nix

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

  networking.hostName = "xps15";
  networking.interfaces.wlp59s0.useDHCP = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/61091175-276e-4591-ba9c-bc0d95c1ed8c";
    preLVM = true;
    allowDiscards = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.clemens = ./home.nix;

  system.stateVersion = "21.05";
}
