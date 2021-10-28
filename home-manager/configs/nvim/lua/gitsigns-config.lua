-- ---------------------------------------- bufferline -------------------------------------------------------

local M = {}

M.load = function()

  require('gitsigns').setup()

  local opt = {noremap = true, silent = true}

  -- mappings
  vim.api.nvim_set_keymap("n", "<Leader>hm", [[<Cmd>Gitsigns next_hunk<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>hn", [[<Cmd>Gitsigns prev_hunk<CR>]], opt)

end

return M
