{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.enable) {
    systemd.user.services.update-dev-tools.Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.zsh}/bin/zsh -c "/home/clemens/.nix-profile/bin/update-dev-tools"
      '';
    };

    systemd.user.timers.update-dev-tools = {
      Install.WantedBy = [ "timers.target" ];
      Unit.PartOf = [ "update-dev-tools.service" ];
      Timer.OnCalendar = [ "weekly" ];
      Timer.Persistent = true;
    };
  };
}
