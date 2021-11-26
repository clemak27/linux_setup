{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.enable) {
    systemd.user.services.update-nvim-tools.Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.zsh}/bin/zsh -c "/home/clemens/.nix-profile/bin/update-nvim-dev"
      '';
    };

    systemd.user.timers.update-nvim-tools = {
      Install.WantedBy = [ "timers.target" ];
      Unit.PartOf = [ "update-nvim-tools.service" ];
      Timer.OnCalendar = [ "weekly" ];
      Timer.Persistent = true;
    };
  };
}
