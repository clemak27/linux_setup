{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homecfg.zsh;
in
{
  config = lib.mkIf (cfg.enable) {
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.direnv.enableZshIntegration = true;

    programs.zsh = {
      sessionVariables = {
        DIRENV_LOG_FORMAT = "";
        PRE_COMMIT_COLOR = "never";
      };
    };
  };
}
