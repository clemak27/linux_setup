{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.advanced) {

    programs.neovim.plugins = with pkgs; [
      vimPlugins.nvim-lspconfig
      vimPlugins.lspkind-nvim
      vimPlugins.popfix
      vimPlugins.nvim-lsputils
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-ui

      nodePackages.vim-language-server
      sumneko-lua-language-server

      nodePackages.bash-language-server

      rnix-lsp

      nodePackages.yaml-language-server

      nodePackages.vscode-langservers-extracted
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('lsp-config').load()
      lua require('lspkind-config').load()
      lua require('lsputils-config').load()
      lua require('nvim-dap-config').load()
      lua require('nvim-dap-ui-config').load()
    '';

    xdg.configFile = {
      "nvim/lua/lsp-config.lua".source = ../lua/lsp-config.lua;
      "nvim/lua/lspkind-config.lua".source = ../lua/lspkind-config.lua;
      "nvim/lua/lsputils-config.lua".source = ../lua/lsputils-config.lua;
      "nvim/lua/nvim-dap-config.lua".source = ../lua/nvim-dap-config.lua;
      "nvim/lua/nvim-dap-ui-config.lua".source = ../lua/nvim-dap-ui-config.lua;
    };

    home.file = {
      ".local/bin/nvim/dap/start_debugger.sh".source = ./start_debugger.sh;
    };
  };
}
