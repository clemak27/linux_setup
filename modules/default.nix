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
    defaultLocale = "en_US.UTF-8";
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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCyRaO8psuZI2i/+inKS5jn765Uypds8ORj/nVkgSE3 maxwell"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3PSHWVz5/LwHEEfo+7y2o5KH7dlLyfySWnyyi7LLxe newton"
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

  # podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  environment.sessionVariables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };

  # packages
  environment.systemPackages = with pkgs; [
    curl
    dig
    gettext
    parted
    sbctl
    usbutils
    wget
  ];
  programs = {
    git.enable = true;
    vim.enable = true;
    zsh.enable = true;
    gnupg.agent.enable = true;
  };

  services.envfs.enable = true;

  # remove once https://github.com/NixOS/nixpkgs/pull/377468 is in unstable
  nixpkgs.config.permittedInsecurePackages = [
    "electron-31.7.7"
  ];
}
