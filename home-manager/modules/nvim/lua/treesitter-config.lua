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

end

return M
