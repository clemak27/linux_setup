-- ---------------------------------------- lualine ------------------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      config = function()
        require("nvim-navic").setup({
          lsp = {
            auto_attach = true,
            preference = { "volar", "tsserver" },
          },
          highlight = true,
        })
      end,
    },
  },
  config = function()
    local C = require("catppuccin.palettes").get_palette("mocha")
    local function navic()
      local navic = require("nvim-navic")
      if navic.is_available() then
        return navic.get_location(opts, bufnr)
      else
        return ""
      end
    end

    local function macro_recording()
      local mode = require("noice").api.statusline.mode.get()
      if mode then
        return string.match(mode, "^recording @.*") or ""
      end
      return ""
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
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
            macro_recording,
          },
          {
            navic,
          },
        },
        lualine_x = {
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
