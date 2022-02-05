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
    vim.api.nvim_exec([[
      nmap r  <Plug>ReplaceWithRegisterOperator
      nmap rr <Plug>ReplaceWithRegisterLine
      nmap R  r$
      xmap r  <Plug>ReplaceWithRegisterVisual
    ]], false)

    use 'tpope/vim-commentary'
    vim.api.nvim_exec([[
      autocmd FileType nix setlocal commentstring=#\ %s
    ]], false)

    use { 'windwp/nvim-autopairs', config = function () require("autopairs-config").load() end }
    use 'tpope/vim-surround'
    use 'antoinemadec/FixCursorHold.nvim'

    ----------------- git integration -----------------------------------

    use 'tpope/vim-fugitive'
    use { 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}, config = function () require("gitsigns-config").load() end }

    ----------------- custom textobjects --------------------------------
    use 'kana/vim-textobj-user'
    use 'kana/vim-textobj-entire'
    use { 'sgur/vim-textobj-parameter',
      config = function ()
        vim.g.vim_textobj_parameter_mapping = 'a'
      end
    }

    ----------------- theming -------------------------------------------
    use { 'olimorris/onedarkpro.nvim', config = function () require("colorscheme-config").load() end }
    use 'kyazdani42/nvim-web-devicons'
    use { 'nvim-lualine/lualine.nvim', config = function () require("lualine-config").load() end }
    use { 'akinsho/nvim-bufferline.lua', config = function () require("bufferline-config").load() end }
    use { 'nvim-treesitter/nvim-treesitter', config = function () require("treesitter-config").load() end }
    use { 'norcalli/nvim-colorizer.lua', config = function () require("nvim-colorizer-config").load() end }

    ----------------- markdown ------------------------------------------
    use { 'preservim/vim-markdown',
      config = function ()
        vim.o.conceallevel = 2
        -- vim.api.nvim_exec([[
        --   let g:vim_markdown_folding_disabled = 1
        --   let g:vim_markdown_emphasis_multiline = 0
        --   let g:vim_markdown_conceal_code_blocks = 0
        --   let g:vim_markdown_new_list_item_indent = 2
        -- ]], false)
        vim.api.nvim_set_keymap("n", "<Leader>ww", [[<Cmd>e ~/Notes/index.md<CR>]], {noremap = true, silent = true})
      end
    }
    use 'godlygeek/tabular'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

    ----------------- vimtex --------------------------------------------
    use { 'lervag/vimtex',
      config = function ()
        vim.g.vimtex_syntax_conceal_default = 0
        vim.g.vimtex_indent_enabled = 1
        vim.g.vimtex_indent_conditionals = {}
        vim.g.vimtex_indent_on_ampersands = 0
        vim.g.vimtex_complete_close_braces = 1
        vim.g.vimtex_format_enabled = 1
        vim.g.vimtex_imaps_leader = ';'
        vim.g.vimtex_quickfix_open_on_warning = 0
      end
    }

    ----------------- fzf -----------------------------------------------
    use { 'ibhagwan/fzf-lua', requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}, config = function() require('fzf-lua-config').load() end }

    ----------------- LSP -----------------------------------------------
    use { 'neovim/nvim-lspconfig', config = function() require('lsp-config').load() end }
    use { 'onsails/lspkind-nvim', config = function() require('lspkind-config').load() end }
    use { 'ojroques/nvim-lspfuzzy', requires = {'junegunn/fzf', 'junegunn/fzf.vim'}, config = function() require('lspfuzzy').setup {} end  }
    use 'williamboman/nvim-lsp-installer'
    use { 'mfussenegger/nvim-jdtls', ft = {'java'}, config = function() require('jdtls-config').load() end}

    ----------------- cmp -----------------------------------------------

    use { 'hrsh7th/nvim-cmp',
      requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-vsnip', 'ray-x/cmp-treesitter'},
      config = function() require('nvim-cmp-config').load() end
    }

    ----------------- snippets ------------------------------------------
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'rafamadriz/friendly-snippets'

    ----------------- lint ----------------------------------------------
    use { 'mfussenegger/nvim-lint', config = function() require('nvim-lint-config').load() end }

    if packer_bootstrap then
      require('packer').sync()
    end
  end)

end

return M
