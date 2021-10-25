{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  options.homecfg.nvim.telescope = lib.mkEnableOption "Enable telescope (fuzzy finder)";

  config = lib.mkIf (cfg.telescope) {

    programs.neovim.plugins = with pkgs.vimPlugins; [
      popup-nvim
      plenary-nvim
      telescope-nvim
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('telescope-config').load()
    '';

    xdg.configFile = {
      "nvim/lua/telescope-config.lua".source = ./lua/telescope-config.lua;
    };
  };
}
