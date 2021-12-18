-- ---------------------------------------- treesitter ---------------------------------------------------------

local M = {}

M.load = function()

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
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

  -- json5 support
  vim.api.nvim_exec(
    [[
    au BufNewFile,BufRead *.json5 setfiletype json5
    ]],
    false
  )
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.jsonc.used_by = "json5"

end

return M
