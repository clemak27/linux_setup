-- ---------------------------------------- bufferline -------------------------------------------------------

local M = {}

M.load = function()

require("bufferline").setup {
  options = {
    numbers = "ordinal",
    number_style = "",
    mappings = true,
    diagnostics = false,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
  }
}

end

return M
