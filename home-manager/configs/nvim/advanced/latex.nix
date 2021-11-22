{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
  vimTexConfig = ''
    let g:vimtex_syntax_conceal_default = 0
    let g:vimtex_indent_enabled = 1
    let g:vimtex_indent_conditionals = {}
    let g:vimtex_indent_on_ampersands = 0
    let g:vimtex_complete_close_braces = 1
    let g:vimtex_format_enabled = 1
    let g:vimtex_imaps_leader = ';'
    let g:vimtex_quickfix_open_on_warning = 0
  '';
in
{
  config = lib.mkIf (cfg.advanced) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      vimtex
    ];

    homecfg.nvim.pluginSettings = vimTexConfig;

    home.packages = with pkgs; [
      texlab
    ];
  };
}
