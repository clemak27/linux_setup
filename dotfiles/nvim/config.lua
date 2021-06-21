require('base16-colorscheme').setup({
    base00 = '#121212', base01 = '#232323', base02 = '#121212', base03 = '#121212',
    base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
    base08 = '#e06c75', base09 = '#d19a66', base0A = '#c678dd', base0B = '#abb2bf',
    base0C = '#56b6c2', base0D = '#98c379', base0E = '#e5c07b', base0F = '#a06949',
  })

local custom_onedark = require'lualine.themes.onedark'
custom_onedark.normal.a.gui = nil
custom_onedark.insert.a.gui = nil
custom_onedark.visual.a.gui = nil
custom_onedark.replace.a.gui = nil
custom_onedark.inactive.a.gui = nil
custom_onedark.normal.b.bg = '#232323'
custom_onedark.normal.c.bg = '#121212'

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
