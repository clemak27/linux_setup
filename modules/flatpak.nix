{ config, pkgs, ... }:
let
  initFlatpak = pkgs.writeShellScriptBin "init-flatpak" ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
      com.github.tchx84.Flatseal \
      com.valvesoftware.Steam \
      io.github.Foldex.AdwSteamGtk \
      org.freedesktop.Platform.VulkanLayer.gamescope \
      org.freedesktop.Platform.VulkanLayer.MangoHud \
      org.freedesktop.Platform.ffmpeg-full \
      org.openrgb.OpenRGB \
      org.zdoom.GZDoom \
      com.valvesoftware.Steam.CompatibilityTool.Proton-GE
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    initFlatpak
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
