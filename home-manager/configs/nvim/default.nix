{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.nvim;
  pluginSettings = config.homecfg.nvim.pluginSettings;
in
{
  imports = [
    ./plugins.nix
    ./advanced
    ./telescope.nix
    ./snippets.nix
  ];

  options.homecfg.nvim.enable = lib.mkEnableOption "Manage neovim with homecfg";

  config = lib.mkIf (cfg.enable) {

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig =
        builtins.readFile (./. + "/init.vim") +
        builtins.readFile (./. + "/de_mappings.vim") +
        pluginSettings;
    };

    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "notes"; value = "nvim ~/Notes/index.md"; }
      ]
    );

    xdg.configFile = {
      "nvim/lua/autopairs-config.lua".source = ./lua/autopairs-config.lua;
      "nvim/lua/nvim-cmp-config.lua".source = ./lua/nvim-cmp-config.lua;
      "nvim/lua/gitsigns-config.lua".source = ./lua/gitsigns-config.lua;
      "nvim/lua/colorscheme-config.lua".source = ./lua/colorscheme-config.lua;
      "nvim/lua/lualine-config.lua".source = ./lua/lualine-config.lua;
      "nvim/lua/bufferline-config.lua".source = ./lua/bufferline-config.lua;
      "nvim/lua/treesitter-config.lua".source = ./lua/treesitter-config.lua;
      "nvim/lua/nvim-colorizer-config.lua".source = ./lua/nvim-colorizer-config.lua;
    };
  };

}
