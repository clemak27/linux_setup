{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-music
    gnome-terminal
    epiphany
    totem
    gnome-tour
    geary
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    evolution
    libnotify

    adw-gtk3
    libsForQt5.qtstyleplugin-kvantum
  ];

  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
    pkgs.gst_all_1.gst-vaapi
  ];

  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "kvantum";
}
