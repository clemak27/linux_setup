{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.gedit
    epiphany
    gnome.totem
    gnome-tour
    gnome.geary
  ];

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    libnotify

    papirus-icon-theme
    adw-gtk3
    gradience
    catppuccin-cursors.mochaDark

    libsForQt5.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "Mauve";
      variant = "Mocha";
    })
  ];

  # Configure keymap in X11
  services.xserver.layout = "de";

  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "kvantum";
}
