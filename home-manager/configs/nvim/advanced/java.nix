{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.advanced && config.homecfg.dev.java && config.homecfg.dev.tools) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-jdtls
    ];

    homecfg.nvim.pluginSettings = ''
      augroup lsp
        au!
        au FileType java lua require('jdtls-config').load()
      augroup end
    '';

    xdg.configFile = {
      "nvim/lua/jdtls-config.lua".source = ../lua/jdtls-config.lua;
    };
  };
}
