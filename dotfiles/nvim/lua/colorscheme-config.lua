-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()

  vim.g.onedark_style = vim.g.onedark_style or 'dark'
  local highlights = require('colorscheme-highlights')
  local terminal = require('colorscheme-terminal')

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = "onedark_custom"
  highlights.setup()
  terminal.setup()

end

return M
