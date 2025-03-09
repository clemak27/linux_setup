{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libnotify

    kdePackages.kdepim-addons

    haruna
    kid3-kde
    krita
  ];

  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = false;
  };

  qt.enable = true;
  qt.platformTheme = "kde";
  qt.style = "breeze";

  services.geoclue2.enable = true;

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  };

  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
