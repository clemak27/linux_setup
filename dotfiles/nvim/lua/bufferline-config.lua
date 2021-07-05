-- ---------------------------------------- bufferline -------------------------------------------------------

local M = {}

M.load = function()

  require("bufferline").setup {
    options = {
      numbers = "ordinal",
      number_style = "",
      mappings = true,
      diagnostics = false,
      custom_filter = function(buf_number)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "dap-repl" then
          return true
        end
      end,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = "thick",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
    }
  }

end

return M
