# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./secrets.nix

    ./logitech_rgb.nix

    ../../modules/sddm.nix
    ../../modules/gaming.nix
    ../../modules/virt-manager.nix
    ../../modules/container.nix
  ];

  # use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/ea64b075-abb6-475f-b4c9-6839f5907664";
    preLVM = true;
    allowDiscards = true;
  };

  networking.hostName = "zenix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # allow ports for kde connect
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp27s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "de";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable KDE Plasma 5.
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    media-session.enable = true;
  };

  # Enable blueooth
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # mount additional HDDs
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/home/clemens/Games" = {
    device = "/dev/disk/by-uuid/5E2CCEED67691F72";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=1000" "user" "exec" "umask=000" ];
  };

  fileSystems."/home/clemens/Archive" = {
    device = "/dev/disk/by-uuid/48764082764072AC";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=1000" "user" "exec" "umask=000" ];
  };
  fileSystems."/home/clemens/Videos" = {
    device = "/dev/disk/by-uuid/ACE41486E4145544";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "gid=1000" "user" "exec" "umask=000" ];
  };
  fileSystems."/home/clemens/.ssd_games" = {
    device = "/dev/disk/by-uuid/692ccaac-ce21-45aa-bdd4-7d7ea5b2e497";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  # add novideo driver :(
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.screenSection = ''
    Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
  '';
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.clemens = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    w3m
    git
    wireguard
    xclip
    sshfs
    parted
  ];

  # Add Fira Code
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
