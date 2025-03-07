return {
  {
    "catppuccin/nvim",
    as = "catppuccin",
    priority = 1000,
    config = function()
      local navicBG
      if os.getenv("NVIM_TRANSPARENT") == "true" then
        navicBG = ""
      else
        navicBG = "#181825"
      end

      require("catppuccin").setup({
        flavour = "mocha",
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        transparent_background = os.getenv("NVIM_TRANSPARENT") == "true",
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            NvimTreeVertSplit = { link = "VertSplit" },
            ["@field"] = { fg = colors.red },
          }
        end,
        no_italic = true,
        integrations = {
          cmp = true,
          fidget = true,
          gitgutter = true,
          gitsigns = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          navic = {
            enabled = true,
            custom_bg = navicBG,
          },
          noice = true,
          notify = true,
          nvimtree = true,
          treesitter = true,
        },
      })

      vim.wo.fillchars = "eob: "
      vim.wo.cursorline = true
      vim.cmd.colorscheme("catppuccin")
      if os.getenv("NVIM_TRANSPARENT") == "true" then
        vim.wo.cursorlineopt = "number"
      end
    end,
  },
}
