-- ---------------------------------------- packer-nvim -------------------------------------------------------

local M = {}

M.load = function()

  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end

  require('packer').startup(function(use)
    ----------------- packer --------------------------------------------
    use 'wbthomason/packer.nvim'

    ----------------- default plugins -----------------------------------

    use 'tpope/vim-repeat'
    use 'tpope/vim-vinegar'
    use 'inkarkat/vim-ReplaceWithRegister'
    use 'tpope/vim-commentary'
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-surround'
    use 'antoinemadec/FixCursorHold.nvim'

    ----------------- git integration -----------------------------------

    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    ----------------- custom textobjects --------------------------------
    use 'kana/vim-textobj-user'
    use 'kana/vim-textobj-entire'
    use 'sgur/vim-textobj-parameter'

    ----------------- theming -------------------------------------------
    use 'olimorris/onedarkpro.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/nvim-bufferline.lua'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'norcalli/nvim-colorizer.lua'

    ----------------- markdown ------------------------------------------
    use {
      'preservim/vim-markdown',
      config = function()
        require('vim-markdown-config').load()
      end
    }
    use 'godlygeek/tabular'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
    ----------------- vimtex --------------------------------------------
    use 'lervag/vimtex'

    ----------------- telescope -----------------------------------------
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'ibhagwan/fzf-lua'

    ----------------- LSP -----------------------------------------------
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'RishabhRD/popfix'
    use 'RishabhRD/nvim-lsputils'
    use 'williamboman/nvim-lsp-installer'

    ----------------- cmp -----------------------------------------------
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'ray-x/cmp-treesitter'

    ----------------- snippets -----------------------------------------------
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'rafamadriz/friendly-snippets'

    ----------------- lint -----------------------------------------------
    use 'mfussenegger/nvim-lint'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)

end

return M
