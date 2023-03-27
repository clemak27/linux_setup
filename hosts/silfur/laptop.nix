{ config, pkgs, ... }:
{
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  # enable tlp (https://github.com/NixOS/nixos-hardware/issues/260)
  services.tlp.enable = false;
}
