{ pkgs, ... }:
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
      pkgs.jq
    ];
    environment = {
      DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
    };
    serviceConfig = {
      ExecStart = "${pkgs.zsh}/bin/zsh -l -c /home/clemens/.linux_setup/modules/autoupdate.sh";
      Type = "oneshot";
      User = "clemens";
      Group = "users";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/clemens/.linux_setup";
    dates = "4:20";
    allowReboot = false;
    operation = "boot";
    flags = [ "--impure" ];
  };
}
