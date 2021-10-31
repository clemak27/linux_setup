{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
in
{
  options.homecfg.nvim.lsp.neovim = lib.mkEnableOption "Enable vim and lua ls";

  config = lib.mkIf (cfg.neovim && config.homecfg.dev.node.enable) {
    home.packages = with pkgs; [
      nodePackages.vim-language-server
      sumneko-lua-language-server
    ];
  };
}
