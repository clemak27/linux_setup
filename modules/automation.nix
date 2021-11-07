{ config, pkgs, ... }:
{
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
}
