-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()

local onedarkpro = require('onedarkpro')
onedarkpro.setup({
  theme = 'onedark'
})
onedarkpro.load()

end

return M
