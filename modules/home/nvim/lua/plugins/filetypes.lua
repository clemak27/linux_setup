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
}
