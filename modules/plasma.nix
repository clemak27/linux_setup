{ config, pkgs, ... }:
{
  imports = [
    ./sddm.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable KDE Plasma 5.
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  environment.systemPackages = with pkgs; [
    xclip
  ];
}
