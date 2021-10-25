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

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      keepassxc
      partition-manager
      openrgb
      sddmTheme
      scrcpy
    ];

    programs.rofi.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/80702
    # https://github.com/NixOS/nixpkgs/issues/122671
    # https://github.com/guibou/nixGL/
    programs.alacritty.enable = true;
    programs.firefox.enable = true;
    programs.mpv.enable = true;
    services.syncthing.enable = true;

    # workaround to find .desktop files with rofi (on non NisOS)
    # adding to PATH did nothing ¯\_(ツ)_/¯
    # https://nixos.wiki/wiki/Nix_Cookbook#Desktop_environment_does_not_find_.desktop_files
    home.file.".local/share/applications/nix".source = ~/.nix-profile/share/applications;
    home.file.".local/share/applications/nix".recursive = true;

  };
}
