{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kdePackages.kdepim-addons
    krita
  ];

  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = false;
  };

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
  };

  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
