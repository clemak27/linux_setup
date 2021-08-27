-- ---------------------------------------- bufferline -------------------------------------------------------

local M = {}

M.load = function()

  require("bufferline").setup {
    options = {
      numbers = "ordinal",
      number_style = "",
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

  local opt = {noremap = true, silent = true}

  -- mappings
  vim.api.nvim_set_keymap("n", "<Leader>1", [[<Cmd>BufferLineGoToBuffer 1<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>2", [[<Cmd>BufferLineGoToBuffer 2<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>3", [[<Cmd>BufferLineGoToBuffer 3<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>4", [[<Cmd>BufferLineGoToBuffer 4<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>5", [[<Cmd>BufferLineGoToBuffer 5<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>6", [[<Cmd>BufferLineGoToBuffer 6<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>7", [[<Cmd>BufferLineGoToBuffer 7<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>8", [[<Cmd>BufferLineGoToBuffer 8<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>9", [[<Cmd>BufferLineGoToBuffer 9<CR>]], opt)

end

return M
