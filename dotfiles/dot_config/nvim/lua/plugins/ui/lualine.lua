-- ---------------------------------------- lualine ------------------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {},
  config = function()
    local C = require("catppuccin.palettes").get_palette("mocha")

    require("lualine").setup({
      options = {
        theme = "catppuccin-nvim",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "mode",
            color = function(section)
              if vim.fn.mode() == "n" then
                return { fg = C.blue, gui = "bold" }
              elseif vim.fn.mode() == "i" then
                return { fg = C.teal, gui = "bold" }
              elseif vim.fn.mode() == "t" then
                return { fg = C.teal, gui = "bold" }
              elseif vim.fn.mode() == "c" then
                return { fg = C.peach, gui = "bold" }
              elseif vim.fn.mode() == "v" then
                return { fg = C.mauve, gui = "bold" }
              elseif vim.fn.mode() == "r" then
                return { fg = C.red, gui = "bold" }
              end
            end,
          },
          "filetype",
          {
            "filename",
            separator = "|",
          },
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_x = {
          "overseer",
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            separator = "|",
          },
          "searchcount",
          "location",
          "diff",
          { "branch", icon = "", color = { fg = C.green, gui = "bold" } },
        },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
