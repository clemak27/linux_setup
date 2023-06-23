{ config, pkgs, ... }:
{
  systemd.services.nixos-update = {
    description = "NixOS Update";
    requiredBy = [ "nixos-upgrade.service" ];
    before = [ "nixos-upgrade.service" ];
    path = [
      pkgs.busybox
      pkgs.coreutils
      pkgs.flatpak
      pkgs.git
      pkgs.home-manager
      pkgs.jq
      pkgs.libnotify
      pkgs.neovim
      pkgs.openssh
    ];
    environment = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
    };
    serviceConfig = {
      ExecStart = "${pkgs.zsh}/bin/zsh -l -c /home/clemens/Projects/linux_setup/modules/autoupdate.sh";
      Type = "oneshot";
      User = "clemens";
      Group = "users";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/clemens/Projects/linux_setup";
    dates = "daily";
    allowReboot = false;
    operation = "switch";
    flags = [ "--impure" ];
  };
}
