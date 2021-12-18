{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gamemode
    mangohud
    # wine-staging (version with experimental features)
    winePackages.staging

    # winetricks and other programs depending on wine need to use the same wine version
    winetricks
    vulkan-tools
  ];
}
