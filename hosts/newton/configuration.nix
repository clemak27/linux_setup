{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./mounts.nix
    ./wireguard.nix

    ./gpu.nix
  ];

  networking.hostName = "newton";

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/ebc5b301-9320-496f-866f-6b808d6beba2";
    preLVM = true;
    allowDiscards = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";

  services.libinput.enable = true;
  hardware.xone.enable = true;

  system.stateVersion = "24.05";
}
