{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.enable) {
    systemd.user.services.update-dev-tools.Service = {
      Type = "oneshot";
      ExecStartPre = ''
        ${pkgs.zsh}/bin/zsh -c "notify-send 'Updating dev-tools' 'Starting...' --icon=dialog-information"
      '';
      ExecStart = ''
        ${pkgs.zsh}/bin/zsh -c "/home/clemens/.nix-profile/bin/update-dev-tools"
      '';
      ExecStartPost = ''
        ${pkgs.zsh}/bin/zsh -c "notify-send 'Updating dev-tools' 'Done!' --icon=dialog-information"
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
