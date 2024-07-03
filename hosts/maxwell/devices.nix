{ pkgs, ... }:
let
  openrgbUdev = pkgs.fetchurl {
    url = "https://openrgb.org/releases/release_0.9/60-openrgb.rules";
    hash = "sha256-txvs6bHped0IVUoktwA7bXu2136lVOJhNUI/hMGvqzg=";
  };
in
{
  environment.systemPackages = with pkgs; [
    piper
  ];

  services.ratbagd.enable = true;

  services.hardware.openrgb.enable = true;
  services.udev.extraRules = ''
    ${openrgbUdev}
  '';

  hardware.keyboard.qmk.enable = true;
}
