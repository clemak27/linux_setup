vim.opt.termguicolors = true
require('base16-colorscheme').setup({
    base00 = '#121212', base01 = '#232323', base02 = '#232323', base03 = '#555555',
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

require("bufferline").setup{
  options = {
    numbers = "ordinal",
    number_style = "",
    mappings = true,
    diagnostics = false,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = true
  }
}

vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false

require("telescope")

local opt = {noremap = true, silent = true}

-- mappings
vim.api.nvim_set_keymap("n", "<Leader>b", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)

vim.api.nvim_set_keymap("n", "<Leader>f", [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>g", [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>i", [[<Cmd>lua require('telescope.builtin').git_status()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>p", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
