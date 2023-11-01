{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    # https://github.com/ValveSoftware/gamescope/issues/660#issuecomment-1289895009
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };


  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode

    prismlauncher
    gzdoom
  ];

  # enable flatpak to access system-fonts
  # https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.fonts;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };
}
