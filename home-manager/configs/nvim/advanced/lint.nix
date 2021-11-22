{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  config = lib.mkIf (cfg.advanced) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      nvim-lint
    ];

    home.packages = with pkgs; [
      shellcheck
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('nvim-lint-config').load()
    '';

    xdg.configFile = {
      "nvim/lua/nvim-lint-config.lua".source = ../lua/nvim-lint-config.lua;
    };
  };
}
