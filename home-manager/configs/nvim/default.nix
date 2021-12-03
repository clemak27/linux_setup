{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{

  options.homecfg.nvim.enable = lib.mkEnableOption "Manage neovim with homecfg";

  config = lib.mkIf (cfg.enable) {

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = builtins.readFile (./. + "/init.vim");
    };

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "notes"; value = "nvim ~/Notes/index.md"; }
      ]
    );
    home.packages = with pkgs; [
      nodePackages.bash-language-server
      nodePackages.eslint
      nodePackages.markdownlint-cli
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.vls
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      rnix-lsp
      shellcheck
      sumneko-lua-language-server
      texlab
    ];
    home.file = {
      ".markdownlintrc".source = ./markdownlintrc;
      ".vsnip".source = ./vsnip;
      ".local/bin/nvim/dap/start_debugger.sh".source = ./start_debugger.sh;
    };
    xdg.configFile = {
      "nvim/lua".source = ./lua;
    };

  };

}
