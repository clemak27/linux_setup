{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasma";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    khelpcenter
    plasma-browser-integration
  ];

  environment.systemPackages = with pkgs; [
    libnotify
    adw-gtk3
    papirus-icon-theme

    kdePackages.kdeconnect-kde
    kdePackages.kdepim-addons
    kdePackages.ksshaskpass
    kdePackages.partitionmanager

    haruna
    kid3-kde
    krita
  ];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = false;
  };

  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style = "breeze";

  environment.sessionVariables = {
    SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
