{ config, lib, pkgs, ... }:
let
  pluginFromGitBranch = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  pluginFromGitLatest = pluginFromGitBranch "HEAD";

  colorScheme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "onedark.nvim";
    version = "614c8fc94d4bd99c34fe6b8d24b9f4bff89f003f";
    src = pkgs.fetchFromGitHub {
      owner = "ful1e5";
      repo = "onedark.nvim";
      rev = "614c8fc94d4bd99c34fe6b8d24b9f4bff89f003f";
      sha256 = "0ffbyjwhpmpcy864a8ck68x6wcz271hz1ai9yz58k7q31nz652c7";
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
      nvim-compe
      nvim-autopairs
      FixCursorHold-nvim
      vim-fugitive
      gitsigns-nvim
      vim-textobj-user
      vim-textobj-entire
      (pluginFromGitLatest "sgur/vim-textobj-parameter")
      colorScheme
      (pluginFromGitLatest "nvim-lualine/lualine.nvim")
      nvim-web-devicons
      (pluginFromGitLatest "akinsho/nvim-bufferline.lua")
      nvim-colorizer-lua
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
    ];

    homecfg.nvim.pluginSettings = ''
      autocmd FileType nix setlocal commentstring=#\ %s

      nmap r  <Plug>ReplaceWithRegisterOperator
      nmap rr <Plug>ReplaceWithRegisterLine
      nmap R  r$
      xmap r  <Plug>ReplaceWithRegisterVisual

      lua require("nvim-compe-config").load()
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
