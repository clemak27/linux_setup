{ pkgs, ... }:
{

  services.flatpak.packages = [
    "org.freedesktop.Platform.VulkanLayer.MangoHud//23.08"
    "org.freedesktop.Platform.VulkanLayer.MangoHud//24.08"
    "org.freedesktop.Platform.VulkanLayer.gamescope//24.08"
  ];

  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    gamemode

    prismlauncher
    gzdoom
    dsda-doom
  ];
}
