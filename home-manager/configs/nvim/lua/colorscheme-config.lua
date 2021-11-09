-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()

  require('onedark').setup( {
    colors = {
      bg = "#121212",
      bg2 = "#121212",
      bg_linenumber = "#121212"
    }
  })

end

return M
