{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.zsh;
  inSecureDirs = if pkgs.stdenv.isDarwin then "true" else "false";
in
{
  imports = [
    ./starship.nix
    ./direnv.nix
  ];

  options.homecfg.zsh.enable = lib.mkEnableOption "Manage zsh with home-manager";

  config = lib.mkIf (cfg.enable) {
    programs.zsh = {
      enable = true;
      localVariables = {
        # https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
        PROMPT_EOL_MARK = "";
        ZSH_DISABLE_COMPFIX = inSecureDirs;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "adb"
          "extract"
          "rsync"
        ] ++ lib.optionals pkgs.stdenv.isLinux [
          # podman completion -f /home/clemens/.oh-my-zsh/custom/plugins/podman/_podman zsh
          "podman"
        ];
        custom = "$HOME/.oh-my-zsh/custom";
      };
      shellAliases = builtins.listToAttrs (
        [
          { name = "cd.."; value = "cd .."; }
          { name = "clear_scrollback"; value = "printf '\\33c\\e[3J'"; }
          { name = "q"; value = "exit"; }
        ]
      );

      sessionVariables = {
        BROWSER = "firefox";
        DIRENV_LOG_FORMAT = "";
        EDITOR = "nvim";
        PATH = "$PATH:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.local/bin:$HOME/.local/bin/npm/bin";
        VISUAL = "nvim";
      };
      initExtra = builtins.concatStringsSep "\n" (
        [ ]
        # tea autocomplete
        ++ lib.optionals config.homecfg.git.tea [
          "PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source $HOME/.config/tea/autocomplete.zsh"
        ]
        ++ lib.optionals config.homecfg.git.glab [
          "eval \"$(glab completion -s zsh)\""
        ]
        ++ [
          # no beeps
          "unsetopt beep"
          # custom functions
          "for file in ~/.zsh_functions/*; do . $file; done"
          # local additional zsh file
          "[[ ! -f ~/.local.zsh ]] || source ~/.local.zsh"
        ]
      );
    };

    programs.dircolors.enable = true;

    home.file = {
      ".zsh_functions".source = ./zsh_functions;
    };
  };
}
