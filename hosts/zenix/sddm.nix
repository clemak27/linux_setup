{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  sddmTheme = pkgs.stdenv.mkDerivation {
    name = "chili-sddm-theme";
    src = ./sddm;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/chili
      tar -xzvf $src/sddm-chili.tar.gz -C $out/share/sddm/themes/chili
      cp $src/theme.conf.user $out/share/sddm/themes/chili/theme.conf.user
      cp $src/wallpaper.png $out/share/sddm/themes/chili/wallpaper.png
    '';
  };
in
{
  services.xserver.displayManager.sddm.enable = true;

  environment.systemPackages = with pkgs; [
    sddmTheme
  ];
}
