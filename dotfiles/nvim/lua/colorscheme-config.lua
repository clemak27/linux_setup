-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()

  require('onedark').setup( {
    colors = {
      bg = "#121212"
    }
  })

end

return M
