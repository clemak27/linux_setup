{ pkgs, ... }:
{

  services.flatpak.packages = [
    "org.freedesktop.Platform.VulkanLayer.MangoHud//24.08"
    "org.freedesktop.Platform.VulkanLayer.gamescope//24.08"
  ];

  environment.systemPackages = with pkgs; [
    gamemode

    prismlauncher
    gzdoom
    dsda-doom
  ];
}
