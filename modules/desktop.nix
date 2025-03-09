{ pkgs, config, ... }:
{
  imports = [
    ./firefox.nix
  ];

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
  services.pulseaudio.enable = false;

  # virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.clemens.extraGroups = [ "libvirtd" ];

  # gaming
  hardware.steam-hardware.enable = true;
  environment.systemPackages = with pkgs; [
    gamemode
    dsda-doom
  ];
}
