-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()


  local onedarkpro = require('onedarkpro')
  onedarkpro.setup({
    theme = 'onedark',
    hlgroups = {
      TSField = { fg = "${red}" }
    }
    })
  onedarkpro.load()

end

return M
