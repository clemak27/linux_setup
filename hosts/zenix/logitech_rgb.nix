{ config, pkgs, ... }:
let
  # openrgb-rules = builtins.fetchurl {
  #   url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
  # };
  reloadOpenRGB = pkgs.writeShellScriptBin "reloadOpenRGB" ''
    openrgb -m direct -c 8a2be2
  '';

in
{
  environment.systemPackages = with pkgs; [
    piper
    openrgb
    reloadOpenRGB
  ];

  services.ratbagd.enable = true;

  services.udev.extraRules = ''
    ${builtins.readFile ./60-openrgb.rules}
  '';
  # services.udev.extraRules = [ openrgb ];
}
