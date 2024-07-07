{ config, pkgs, ... }:
{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  hardware.xone.enable = true;
}
