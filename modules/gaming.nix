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

    lutris
    protonup-qt

    prismlauncher
    gzdoom
    dsda-doom
  ];

}
