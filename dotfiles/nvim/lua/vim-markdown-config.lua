-- ---------------------------------------- vim-markdown -------------------------------------------------------

local M = {}

M.load = function()

  vim.g.vim_markdown_folding_disabled = 1
  vim.g.vim_markdown_emphasis_multiline = 0

  vim.api.nvim_set_keymap("n", "<Leader>ww", [[<Cmd>e ~/Notes/index.md<CR>]], {noremap = true, silent = true})

end

return M
