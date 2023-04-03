{ config, pkgs, ... }:
{
  # Enable sound.
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable blueooth
  hardware.bluetooth.enable = true;
  # PipeWire based PulseAudio server emulation replaces PulseAudio. This option requires `hardware.pulseaudio.enable` to be set to false
  hardware.pulseaudio.enable = false;
}