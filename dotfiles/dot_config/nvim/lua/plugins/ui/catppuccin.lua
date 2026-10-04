return {
  {
    "catppuccin/nvim",
    as = "catppuccin",
    tag = "v2.0.0",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        transparent_background = true,
        float = {
          transparent = true,
          solid = false,
        },
        color_overrides = {
          mocha = {
            surface0 = "#2e2e2e",
            base = "#090909",
            crust = "#060606",
            mantle = "#000000",
          },
        },
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

      vim.cmd.colorscheme("catppuccin-nvim")
      vim.wo.cursorlineopt = "number"
    end,
  },
}
