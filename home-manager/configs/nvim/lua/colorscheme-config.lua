-- ---------------------------------------- colorscheme ------------------------------------------------------

local M = {}

M.load = function()

  require('onedark').setup( {
    colors = {
      bg = "#161b22",
      bg2 = "#161b22",
      bg_linenumber = "#161b22"
    }
  })

end

return M
