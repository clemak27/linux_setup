{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ./sops.nix
    ./automation.nix

    ../../modules/ssh.nix

    ./container

    <home-manager/nixos>
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Prevent notbook from sleeping when lid is closed
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    LidSwitchIgnoreInhibited=no
  '';

  # hdds
  fileSystems."/home/clemens/data" = {
    device = "/dev/disk/by-uuid/886f6cde-4ed8-414d-9260-ee5ae4c75786";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."/home/clemens/data_bu" = {
    device = "/dev/disk/by-uuid/03bfac2e-27ba-4a6e-a0a3-1dada4aca0f1";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  networking.hostName = "e470";
  networking.interfaces.enp4s0.useDHCP = true;

  # Enable NAT
  networking.nat = {
    enable = true;
    externalInterface = "enp4s0";
    internalInterfaces = [ "wg0" ];
  };

  # Disable firewall
  networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "de";
  };

  environment.systemPackages = with pkgs; [
    git
    zsh
    wget
    curl
    vim

    dnsutils
    tcpdump
    iptables
  ];

  users.users.clemens = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.clemens = ./home.nix;

  system.stateVersion = "21.05";
}
