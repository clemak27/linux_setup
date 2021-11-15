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
          "docker"
          "timewarrior"
        ] ++ lib.optionals pkgs.stdenv.isLinux [
          "archlinux"
        ] ++ lib.optionals pkgs.stdenv.isDarwin [
          "macos"
        ];
        custom = "$HOME/.oh-my-zsh/custom";
      };
      shellAliases = builtins.listToAttrs (
        [
          { name = "cd.."; value = "cd .."; }
          { name = "clear_scrollback"; value = "printf '\\33c\\e[3J'"; }
          { name = "q"; value = "exit"; }
        ] ++ lib.optionals pkgs.stdenv.isLinux [
          { name = "paruf"; value = "paru -Slq | fzf --multi --preview \"paru -Si {1}\" | xargs -ro paru -S"; }
          { name = "mpvnv"; value = "mpv --no-video"; }
          { name = "spm"; value = "sudo pacman"; }
          { name = "update-grub"; value = "sudo grub-mkconfig -o /boot/grub/grub.cfg"; }
          { name = "youtube-dl-music"; value = "youtube-dl --extract-audio --audio-format mp3 -o \"%(title)s.%(ext)s\""; }
        ]
      );

      sessionVariables = {
        BROWSER = "firefox";
        DIRENV_LOG_FORMAT = "";
        EDITOR = "nvim";
        GIT_SSH = "/usr/bin/ssh";
        MANPAGER = "nvim -c 'set ft=man' -";
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
          # nix
          "${if config.homecfg.NixOS.enable then "" else ". $HOME/.nix-profile/etc/profile.d/nix.sh"}"
          "${if config.homecfg.NixOS.enable then "unset GIT_SSH" else ""}"
        ]
      );
    };

    programs.dircolors.enable = true;

    home.file = {
      ".zsh_functions".source = ./zsh_functions;
    };
  };
}
