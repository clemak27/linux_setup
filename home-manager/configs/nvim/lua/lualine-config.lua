-- ---------------------------------------- lualine ------------------------------------------------------------

local M = {}

M.load = function()

  require('lualine').setup {
    options = {
      theme = "onedarkpro",
      section_separators = '',
      component_separators = '|'
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'filename'},
      lualine_c = {},
      lualine_x = {
        {
          'fileformat',
          icon = false
        },
        'encoding',
        'filetype'
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }

end

return M
