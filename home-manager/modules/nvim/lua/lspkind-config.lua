-- ---------------------------------------- lspkind ------------------------------------------------------------

local M = {}

M.load = function()

  require('lspkind').init({
    mode = 'symbol_text',
    preset = 'default',
    symbol_map = {},
  })

end

return M
