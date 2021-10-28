{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim.lsp;
  repo = "mfussenegger/nvim-lint";
in
{
  config = lib.mkIf (cfg.markdown || cfg.go || cfg.node || cfg.shell) {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "${lib.strings.sanitizeDerivationName repo}";
        version = "master";
        src = builtins.fetchGit {
          url = "https://github.com/${repo}.git";
          ref = "master";
        };
      })
    ];

    homecfg.nvim.pluginSettings = ''
      lua require('nvim-lint-config').load()
    '';

    xdg.configFile = {
      "nvim/lua/nvim-lint-config.lua".source = ./lua/nvim-lint-config.lua;
    };
  };
}
