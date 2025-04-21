return {
  {
    "catppuccin/nvim",
    as = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        transparent_background = true,
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            NvimTreeVertSplit = { link = "VertSplit" },
            ["@field"] = { fg = colors.red },
            ["@comment.todo.comment"] = { fg = colors.yellow, bg = nil },
            DapBreakpointColor = { fg = colors.red },
            DapIconColor = { fg = colors.green },
          }
        end,
        no_italic = false,
        integrations = {
          blink_cmp = true,
          fidget = true,
          gitgutter = true,
          gitsigns = true,
          lsp_trouble = true,
          markdown = true,
          noice = true,
          notify = true,
          nvimtree = true,
          treesitter = true,
        },
      })

      vim.cmd.colorscheme("catppuccin")
      vim.wo.cursorlineopt = "number"
    end,
  },
}
