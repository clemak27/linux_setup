{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    gamemode
    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks and other programs depending on wine need to use the same wine version
    (winetricks.override { wine = wineWowPackages.staging; })
    vulkan-tools
  ];
}
