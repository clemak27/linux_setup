{ pkgs, ... }:
let
  nixUpdate = pkgs.writeShellScriptBin "nixos-update" ''
    set -e

    flatpak update -y

    git clone https://github.com/clemak27/linux_setup.git /tmp/linux_setup
  '';
in
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
      pkgs.openssh
    ];
    environment = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
    };
    serviceConfig = {
      ExecStart = "${pkgs.zsh}/bin/zsh -l -c ${nixUpdate}/bin/nixos-update";
      Type = "oneshot";
      User = "clemens";
      Group = "users";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/tmp/linux_setup";
    dates = "4:20";
    allowReboot = false;
    operation = "boot";
    flags = [ "--impure" ];
  };
}
