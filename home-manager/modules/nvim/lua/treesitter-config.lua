-- ---------------------------------------- treesitter ---------------------------------------------------------

local M = {}

M.load = function()

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = false,
    },
    indent = {
      enable = true
    }
  }

  -- workaround issue with vim-markdown
  vim.api.nvim_exec(
    [[
    au BufNewFile,BufRead *.md TSBufDisable highlight
    ]],
    false
  )

end

return M
