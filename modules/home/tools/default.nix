{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homecfg.tools;
in
{
  options.homecfg.tools.enable = lib.mkEnableOption "Manage command line tools with homecfg";

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      android-tools
      bat
      bat-extras.batman
      htop
      curl
      cyme
      eza
      fd
      gojq
      hurl
      jo
      pgcli
      ripgrep
      sd
      tealdeer
      tree
      unzip
      viddy
      yazi
      yq-go
    ];

    programs.zsh.shellAliases = builtins.listToAttrs ([
      {
        name = "cat";
        value = "bat";
      }
      {
        name = "ls";
        value = "eza --icons";
      }
      {
        name = "lsa";
        value = "eza --icons -hal";
      }
      {
        name = "lsusb";
        value = "cyme --lsusb";
      }
      {
        name = "man";
        value = "batman";
      }
      {
        name = "watch";
        value = "viddy";
      }
      {
        name = "top";
        value = "htop";
      }
    ]);

    home.file = {
      ".local/bin/jq".source = "${pkgs.gojq}/bin/gojq";
      ".config/tealdeer/config.toml".text = ''
        [updates]
        auto_update = true
      '';
      ".config/btop/btop.conf".text = ''
        color_theme = "TTY"
        theme_background = False
        vim_keys = True
        shown_boxes = "cpu mem net proc"
        update_ms = 2000
        cpu_single_graph = True
        net_sync = True
      '';
    };

    xdg.configFile = {
      "bat/config".text = # sh
        ''
          --theme="base16"
          --paging=auto
        '';
    };
  };
}
