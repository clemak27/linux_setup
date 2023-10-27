{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
    khelpcenter
    plasma-browser-integration
  ];

  environment.systemPackages = with pkgs; [
    libnotify

    papirus-icon-theme
    adw-gtk3
    gradience
    catppuccin-cursors.mochaDark
    kdeconnect
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style = "breeze";
}
