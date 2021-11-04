{ config, pkgs, ... }:
{

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

}
