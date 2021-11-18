{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  config = lib.mkIf (cfg.markdown || cfg.go || cfg.node || cfg.shell) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-lint
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('nvim-lint-config').load()
    '';

    xdg.configFile = {
      "nvim/lua/nvim-lint-config.lua".source = ./lua/nvim-lint-config.lua;
    };
  };
}
