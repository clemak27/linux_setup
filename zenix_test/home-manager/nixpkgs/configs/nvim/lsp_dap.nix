{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  config = lib.mkIf (cfg.web || cfg.yaml || cfg.shell || cfg.neovim || cfg.markdown || cfg.java || cfg.go || cfg.node || cfg.vue) {

    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      lspkind-nvim
      popfix
      nvim-lsputils
      nvim-dap
      nvim-dap-ui
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('lsp-config').load()
      lua require('lspkind-config').load()
      lua require('lsputils-config').load()
      lua require('nvim-dap-config').load()
      lua require('nvim-dap-ui-config').load()
    '';

    xdg.configFile = {
      "nvim/lua/lsp-config.lua".source = ./lua/lsp-config.lua;
      "nvim/lua/lspkind-config.lua".source = ./lua/lspkind-config.lua;
      "nvim/lua/lsputils-config.lua".source = ./lua/lsputils-config.lua;
      "nvim/lua/nvim-dap-config.lua".source = ./lua/nvim-dap-config.lua;
      "nvim/lua/nvim-dap-ui-config.lua".source = ./lua/nvim-dap-ui-config.lua;
    };

    home.file = {
      ".local/bin/nvim/dap/start_debugger.sh".source = ./start_debugger.sh;
    };
  };
}
