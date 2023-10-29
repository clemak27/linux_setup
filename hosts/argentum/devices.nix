{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    piper
  ];

  services.ratbagd.enable = true;

  services.hardware.openrgb.enable = true;
  services.udev.extraRules = ''
    ${builtins.readFile ./60-openrgb.rules}
  '';

  hardware.keyboard.qmk.enable = true;
}
