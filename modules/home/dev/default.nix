{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homecfg.dev;
in
{
  options.homecfg.dev.enable = lib.mkEnableOption "Manage development tools with home-manager";

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      delve
      gnumake
      kotlin
      nodejs_22
    ];

    programs.zsh.oh-my-zsh.plugins = [
      "npm"
      "golang"
      "gradle-completion"
    ];

    home.file.".oh-my-zsh/custom/plugins/gradle-completion".source = builtins.fetchGit {
      url = "https://github.com/gradle/gradle-completion";
      ref = "master";
      rev = "25da917cf5a88f3e58f05be3868a7b2748c8afe6";
    };

    home.file.".npmrc".text = ''
      prefix=~/.local/bin/npm
      save-exact=true
    '';

    programs.java = {
      enable = true;
      package = pkgs.temurin-bin;
    };
    programs.gradle.enable = true;

    programs.go = {
      enable = true;
      goPath = ".go";
      package = pkgs.go_1_23;
    };

    # https://utcc.utoronto.ca/~cks/space/blog/programming/Go121ToolchainDownloads
    xdg.configFile = {
      "go/env".text = ''
        GOTOOLCHAIN=local
      '';
    };

    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          charset = "utf-8";
          end_of_line = "lf";
          insert_final_newline = true;
          trim_trailing_whitespace = true;
          indent_size = 2;
          indent_style = "space";
        };
        "{Makefile,*.mk}" = {
          indent_style = "tab";
          tab_width = 2;
        };
        "{*.go,go.mod}" = {
          indent_style = "tab";
          indent_size = 2;
        };
        "*.java" = {
          indent_style = "space";
          indent_size = 4;
        };
      };
    };
  };
}
