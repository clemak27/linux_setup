{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    piper
  ];

  services.ratbagd.enable = true;

  services.hardware.openrgb.enable = true;
  hardware.keyboard.qmk.enable = true;
}
