{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    piper
  ];

  services.ratbagd.enable = true;

  services.udev.extraRules = ''
    ${builtins.readFile ./60-openrgb.rules}
  '';
}