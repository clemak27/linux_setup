{ config, pkgs, ... }:
let
  initFlatpak = pkgs.writeShellScriptBin "init-flatpak" ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
      com.github.tchx84.Flatseal \
      io.gdevs.GDLauncher \
      org.zdoom.GZDoom \
      org.libreoffice.LibreOffice \
      org.gimp.GIMP \
      com.discordapp.Discord \
      com.valvesoftware.Steam \
      net.davidotek.pupgui2 \
      org.signal.Signal
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    initFlatpak
  ];
}
