-- ---------------------------------------- lspkind ------------------------------------------------------------

local M = {}

M.load = function()

  require('lspkind').init({
    with_text = true,
    preset = 'default',
    symbol_map = {},
  })

end

return M
