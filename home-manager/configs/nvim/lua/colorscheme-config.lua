-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()

  require('onedark').setup( {
    colors = {
      bg = "#0c0e14",
      bg2 = "#0c0e14",
      bg_linenumber = "#0c0e14"
    }
  })

end

return M
