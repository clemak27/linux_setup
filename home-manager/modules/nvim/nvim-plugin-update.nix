{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tools;
in
{
  config = lib.mkIf (cfg.enable) {
    systemd.user.services.nvim-plugin-update.Service = {
      Type = "oneshot";
      ExecStartPre = ''
        ${pkgs.zsh}/bin/zsh -c "notify-send 'Updating nvim-plugins' 'Starting...' --icon=dialog-information"
      '';
      ExecStart = ''
        ${pkgs.zsh}/bin/zsh -c "nvim -c 'PlugUpgrade | PlugUpdate | qa'"
      '';
      ExecStartPost = ''
        ${pkgs.zsh}/bin/zsh -c "notify-send 'Updating tealdeer-cache' 'Done!' --icon=dialog-information"
      '';
    };

    systemd.user.timers.nvim-plugin-update = {
      Install.WantedBy = [ "timers.target" ];
      Unit.PartOf = [ "nvim-plugin-update.service" ];
      Timer.OnCalendar = [ "weekly" ];
      Timer.Persistent = true;
    };
  };
}
