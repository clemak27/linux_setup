{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
in
{
  options.homecfg.nvim.snippets = lib.mkEnableOption "Enable snippet support";

  config = lib.mkIf (cfg.snippets) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      vim-vsnip
      vim-vsnip-integ
      friendly-snippets
    ];

    home.file.".vsnip".source = ./vsnip;
  };
}
