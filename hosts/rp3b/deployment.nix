{
  rp3b =
    { config, pkgs, lib, ... }:
    {
      deployment.targetHost = "192.168.0.31";
      nixpkgs.localSystem.system = "aarch64-linux";

      # NixOS wants to enable GRUB by default
      boot.loader.grub.enable = false;

      # if you have a Raspberry Pi 2 or 3, pick this:
      # boot.kernelPackages = pkgs.linuxPackages_latest;

      # A bunch of boot parameters needed for optimal runtime on RPi 3b+
      boot.kernelParams = [ "cma=256M" ];
      boot.loader.raspberryPi.enable = true;
      boot.loader.raspberryPi.version = 3;
      boot.loader.raspberryPi.uboot.enable = true;
      boot.loader.raspberryPi.firmwareConfig = ''
        gpu_mem=256
      '';

      # https://github.com/Robertof/nixos-docker-sd-image-builder/issues/24
      boot.loader.generic-extlinux-compatible.enable = true;
      boot.kernelPackages = pkgs.linuxPackages_5_4;
      # boot.kernelParams = ["cma=64M"];

      environment.systemPackages = with pkgs; [
        libraspberrypi
        git
        zsh
        starship
        wget
        curl
        neovim
        neofetch
      ];

      # File systems configuration for using the installer's partition layout
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/NIXOS_SD";
          fsType = "ext4";
        };
      };

      # Preserve space by sacrificing documentation and history
      documentation.nixos.enable = false;
      nix.gc.automatic = true;
      nix.gc.options = "--delete-older-than 30d";
      boot.cleanTmpDir = true;

      # Configure basic SSH access
      services.openssh.enable = true;
      # services.openssh.permitRootLogin = "yes";

      # Use 2GB of additional swap memory in order to not run out of memory
      # when installing lots of things while running other things at the same time.
      swapDevices = [{ device = "/swapfile"; size = 2048; }];

      security.sudo.wheelNeedsPassword = false;

      users.users.clemens = {
        isNormalUser = true;
        home = "/home/clemens";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" ];
        password = "1234";
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCyRaO8psuZI2i/+inKS5jn765Uypds8ORj/nVkgSE3 lazarus" ];
      };

      # https://github.com/NixOS/nixops/issues/730
      users.extraUsers.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCyRaO8psuZI2i/+inKS5jn765Uypds8ORj/nVkgSE3 lazarus" ];
    };
}
