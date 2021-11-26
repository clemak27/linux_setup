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
  onedark-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "onedark-nvim-git";
    version = "2021-11-05";
    src = builtins.fetchGit {
      url = "https://github.com/ful1e5/onedark.nvim.git";
      ref = "HEAD";
      rev = "3833202fc5b579120a34d37842334cda23ffdfac";
    };
  };
in
{
  options.homecfg.nvim.pluginSettings = lib.mkOption {
    type = lib.types.lines;
  };

  config = {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      vim-repeat
      vim-vinegar
      vim-commentary
      vim-surround
      vim-ReplaceWithRegister
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-treesitter
      cmp-vsnip
      nvim-cmp
      nvim-autopairs
      FixCursorHold-nvim
      vim-fugitive
      gitsigns-nvim
      vim-textobj-user
      vim-textobj-entire
      vim-textobj-parameter
      onedark-nvim
      lualine-nvim
      nvim-web-devicons
      bufferline-nvim
      nvim-colorizer-lua
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
    ];

    homecfg.nvim.pluginSettings = ''
      autocmd FileType nix setlocal commentstring=#\ %s

      nmap r  <Plug>ReplaceWithRegisterOperator
      nmap rr <Plug>ReplaceWithRegisterLine
      nmap R  r$
      xmap r  <Plug>ReplaceWithRegisterVisual

      lua require("nvim-cmp-config").load()
      lua require("autopairs-config").load()
      lua require("gitsigns-config").load()

      let g:vim_textobj_parameter_mapping = 'a'

      lua require("colorscheme-config").load()
      lua require("lualine-config").load()
      lua require("bufferline-config").load()

      lua require("nvim-colorizer-config").load()
      lua require("treesitter-config").load()
    '';
  };

}
