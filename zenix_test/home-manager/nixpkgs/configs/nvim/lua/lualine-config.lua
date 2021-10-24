-- ---------------------------------------- lualine ------------------------------------------------------------

local M = {}

M.load = function()

  local custom_onedark = require'lualine.themes.onedark'
  custom_onedark.normal.a.gui = nil
  custom_onedark.insert.a.gui = nil
  custom_onedark.visual.a.gui = nil
  custom_onedark.replace.a.gui = nil
  custom_onedark.inactive.a.gui = nil
  custom_onedark.inactive.a.bg = '#161b22'
  custom_onedark.inactive.b.bg = '#161b22'
  custom_onedark.inactive.c.bg = '#161b22'
  custom_onedark.normal.b.bg = '#2d333b'
  custom_onedark.normal.c.bg = '#161b22'
  custom_onedark.insert.b.bg = '#2d333b'
  custom_onedark.command.b.bg = '#2d333b'
  custom_onedark.visual.b.bg = '#2d333b'

  require('lualine').setup {
    options = {
      theme = custom_onedark,
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