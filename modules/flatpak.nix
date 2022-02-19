{ config, pkgs, ... }:
let
  initFlatpak = pkgs.writeShellScriptBin "init-flatpak" ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
      com.discordapp.Discord \
      com.github.tchx84.Flatseal \
      com.valvesoftware.Steam \
      com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
      io.gdevs.GDLauncher \
      org.gimp.GIMP \
      org.libreoffice.LibreOffice \
      org.openrgb.OpenRGB \
      org.pipewire.Helvum \
      org.signal.Signal \
      org.zdoom.GZDoom
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    initFlatpak
  ];
}
