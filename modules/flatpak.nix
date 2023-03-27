{ config, pkgs, ... }:
let
  initFlatpak = pkgs.writeShellScriptBin "init-flatpak" ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
      com.discordapp.Discord \
      com.github.GradienceTeam.Gradience \
      com.github.tchx84.Flatseal \
      com.valvesoftware.Steam \
      io.github.Foldex.AdwSteamGtk \
      io.github.celluloid_player.Celluloid \
      org.freedesktop.Platform.VulkanLayer.MangoHud \
      org.freedesktop.Platform.ffmpeg-full \
      org.gimp.GIMP \
      org.kde.kid3 \
      org.libreoffice.LibreOffice \
      org.mozilla.Thunderbird \
      org.mozilla.firefox \
      org.openrgb.OpenRGB \
      org.pipewire.Helvum \
      org.signal.Signal \
      org.wezfurlong.wezterm \
      org.zdoom.GZDoom \
      com.valvesoftware.Steam.CompatibilityTool.Proton-GE \
      com.valvesoftware.Steam.Utility.gamescope

    # firefox should use wayland
    flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
  '';
in
{
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    initFlatpak
  ];
}
