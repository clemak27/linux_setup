{ config, pkgs, ... }:
let
  initFlatpak = pkgs.writeShellScriptBin "init-flatpak" ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
      com.github.tchx84.Flatseal \
      io.github.Foldex.AdwSteamGtk \
      org.freedesktop.Platform.ffmpeg-full
  '';
in
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

  services.flatpak.enable = true;

  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    initFlatpak

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
