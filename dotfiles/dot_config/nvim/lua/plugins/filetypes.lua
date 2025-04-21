return {
  {
    "towolf/vim-helm",
    ft = { "yaml", "helm" },
    config = function()
      vim.api.nvim_create_augroup("helm_filetype", { clear = true })
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = "*/templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml",
        group = "helm_filetype",
        callback = function()
          vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
        end,
      })
    end,
  },
  {
    "lervag/vimtex",
    ft = { "latex" },
    config = function()
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_indent_conditionals = {}
      vim.g.vimtex_indent_on_ampersands = 0
      vim.g.vimtex_complete_close_braces = 1
      vim.g.vimtex_format_enabled = 1
      vim.g.vimtex_imaps_leader = ";"
      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
  },
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup()

      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "o", "o<cmd>AutolistNewBullet<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "O", "O<cmd>AutolistNewBulletBefore<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "<C-r>", "<C-r><cmd>AutolistRecalculate<cr>", opts)
      -- functions to recalculate list on edit
      vim.api.nvim_buf_set_keymap(0, "n", ">>", ">><cmd>AutolistRecalculate<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "<<", "<<<cmd>AutolistRecalculate<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "n", "dd", "dd<cmd>AutolistRecalculate<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "v", "d", "d<cmd>AutolistRecalculate<cr>", opts)
    end,
  },
  {
    "calops/hmts.nvim",
    version = "*",
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("chezmoi").setup({
        notification = {
          on_open = false,
          on_apply = true,
          on_watch = false,
        },
      })

      vim.api.nvim_create_augroup("chezmoi_watch", { clear = true })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = {
          os.getenv("HOME") .. "/Projects/linux_setup/dotfiles/*",
          "/var" .. os.getenv("HOME") .. "/Projects/linux_setup/dotfiles/*",
        },
        group = "chezmoi_watch",
        callback = function(args)
          local bufnr = args.buf
          local edit_watch = function()
            require("chezmoi.commands.__edit").watch(bufnr)
          end
          vim.schedule(edit_watch)
        end,
      })
    end,
  },
}
