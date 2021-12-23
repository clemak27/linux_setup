{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ./sops.nix

    ../../modules/container.nix
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
