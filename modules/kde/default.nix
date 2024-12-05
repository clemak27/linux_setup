{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    defaultSession = "plasma";
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    akregator
    khelpcenter
    oxygen
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
    packages = [
      pkgs.nerd-fonts.jetbrains-mono
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

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  };

  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
