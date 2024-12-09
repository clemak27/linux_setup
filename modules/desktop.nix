{ pkgs, config, ... }:
{
  # flatpak
  services.flatpak.enable = true;
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
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;

  # virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.clemens.extraGroups = [ "libvirtd" ];

  # gaming
  services.flatpak.packages = [
    "org.freedesktop.Platform.VulkanLayer.MangoHud//24.08"
    "org.freedesktop.Platform.VulkanLayer.gamescope//24.08"
  ];
  hardware.steam-hardware.enable = true;
  environment.systemPackages = with pkgs; [
    gamemode

    dsda-doom
  ];
}
