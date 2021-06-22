local M = {}
vim.g.onedark_style = vim.g.onedark_style or 'dark'
local highlights = require('onedark_custom.highlights')
local terminal = require('onedark_custom.terminal')

local function colorscheme()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
    vim.o.background = "dark"
    vim.o.termguicolors = true
     vim.g.colors_name = "onedark_custom"
    highlights.setup()
    terminal.setup()
end

function M.setup() colorscheme() end

return M
