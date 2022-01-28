{ config, lib, pkgs, ... }:
let
  vim-textobj-parameter = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-textobj-parameter-git";
    version = "2017-05-16";
    src = builtins.fetchGit {
      url = "https://github.com/sgur/vim-textobj-parameter.git";
      ref = "HEAD";
      rev = "201144f19a1a7081033b3cf2b088916dd0bcb98c";
    };
  };
in
{
  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      # default plugins
      vim-repeat
      vim-vinegar
      vim-ReplaceWithRegister
      vim-commentary
      nvim-autopairs
      vim-surround
      FixCursorHold-nvim

      # git integration
      vim-fugitive
      gitsigns-nvim

      # custom textobjects
      vim-textobj-entire
      vim-textobj-parameter
      vim-textobj-user

      # theming
      onedarkpro-nvim
      nvim-web-devicons
      lualine-nvim
      bufferline-nvim
      nvim-colorizer-lua

      plenary-nvim
      popup-nvim

      # markdown
      vim-markdown
      tabular

      # vimtex
      vimtex

      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

      nvim-lspconfig
      lspkind-nvim
      nvim-jdtls
      popfix
      nvim-lsputils

      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      nvim-cmp
      cmp-vsnip
      cmp-treesitter

      vim-vsnip
      vim-vsnip-integ
      friendly-snippets

      nvim-lint
    ];

  };

}
