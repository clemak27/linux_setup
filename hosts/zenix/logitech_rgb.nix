{ config, pkgs, ... }:
let
  # openrgb-rules = builtins.fetchurl {
  #   url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
  # };
in
{
  environment.systemPackages = with pkgs; [
    piper
    openrgb
  ];

  services.ratbagd.enable = true;

  services.udev.extraRules = ''
    ${builtins.readFile ./60-openrgb.rules}
  '';
  # services.udev.extraRules = [ openrgb ];
}
