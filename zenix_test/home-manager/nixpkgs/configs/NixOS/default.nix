{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.NixOS;
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
    ];

    programs.rofi.enable = true;

    services.syncthing = {
      enable = true;
    };
  };
}
