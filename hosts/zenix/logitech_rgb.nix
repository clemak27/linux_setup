{ config, pkgs, ... }:
let
  # openrgb-rules = builtins.fetchurl {
  #   url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
  # };
in
{
  environment.systemPackages = with pkgs; [
    libratbag
    piper
    openrgb
  ];

  # services.udev.extraRules = [ openrgb ];
}
