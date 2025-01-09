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
      btop
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

    programs.fzf = {
      enable = true;
      defaultCommand = "rg --files --hidden";
      defaultOptions = [
        "--height=99%"
        "--layout=reverse"
        "--info=inline"
        "--border=sharp"
        "--margin=2"
        "--padding=1"
        "--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8"
        "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
        "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      ];
    };

    programs.zsh.oh-my-zsh.plugins = [
      "fzf"
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
        value = "btop -p 1";
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
