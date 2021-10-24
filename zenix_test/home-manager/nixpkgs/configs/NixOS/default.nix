{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
  sddmTheme = pkgs.stdenv.mkDerivation {
    name = "chili-sddm-theme";
    src = ./plasma;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/chili
      tar -xzvf $src/sddm-chili.tar.gz -C $out/share/sddm/themes/chili
      cp $src/theme.conf.user $out/share/sddm/themes/chili/theme.conf.user
      cp $src/wallpaper.png $out/share/sddm/themes/chili/wallpaper.png
    '';
  };
in
{
  imports = [
    ./plasma/default.nix
  ];

  options.homecfg.NixOS = {
    enable = lib.mkEnableOption "Set to true if home-manager is running on NixOS";
  };

  config = {
    home.packages = with pkgs; [
      keepassxc
      partition-manager
      openrgb
      sddmTheme
    ];
    programs.rofi.enable = true;

    services.syncthing = {
      enable = true;
    };
  };
}
