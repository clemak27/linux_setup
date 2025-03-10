{ pkgs, ... }:
{
  # nix
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      systemd-boot.consoleMode = "max";
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };

  # basic hardware
  security.tpm2.enable = true;
  services.fwupd.enable = true;
  hardware.enableRedistributableFirmware = true;

  # networking
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    firewall.enable = false;
  };

  # locale
  time.timeZone = "Europe/Vienna";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
    };
  };
  console.useXkbConfig = true;

  # user
  users = {
    users.clemens = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "adbusers"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsk9Bh5+4ZsEDFGb7mXDiClvsLwM+jMNr+SPf+auyu7 planck"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA35xMqpMFnqqkPUyDR5KMNQsDMkEKQLIvyvMk0HzVux boltzmann"
      ];
    };
    groups.adbusers = { };
  };
  services.openssh.enable = true;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
