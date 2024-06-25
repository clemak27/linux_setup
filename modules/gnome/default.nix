{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music
    gnome.gnome-terminal
    epiphany
    gnome.totem
    gnome-tour
    gnome.geary
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    evolution
    libnotify
    gst_all_1.gstreamer

    papirus-icon-theme
    gradience
    adw-gtk3
    catppuccin-cursors.mochaDark

    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Blue";
      variant = "Mocha";
    })
  ];


  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "kvantum";
}
