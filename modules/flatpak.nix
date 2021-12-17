{ config, pkgs, ... }:
let
  updateFlatpak = pkgs.writeShellScriptBin "update-flatpak" ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
      com.github.tchx84.Flatseal \
      com.jetbrains.IntelliJ-IDEA-Community \
      io.gdevs.GDLauncher \
      flathub org.zdoom.GZDoom
    flatpak update
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    updateFlatpak
  ];
}
