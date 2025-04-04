return {
  require("plugins.ui.bufferline"),
  require("plugins.ui.catppuccin"),
  require("plugins.ui.gitsigns"),
  require("plugins.ui.lualine"),
  require("plugins.ui.noice"),
  require("plugins.ui.nvim-tree"),
  require("plugins.ui.telescope"),
  require("plugins.ui.treesitter"),

  "kyazdani42/nvim-web-devicons",
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "󰝤",
        virtual_symbol_prefix = " ",
        virtual_symbol_suffix = " ",
        virtual_symbol_position = "inline",
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 1000,
        filetypes_denylist = { "NvimTree" },
      })
    end,
  },
  "stevearc/dressing.nvim",
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
      },
      indent = {
        enabled = true,
        animate = {
          enabled = false,
        },
      },
      quickfile = {
        enabled = true,
      },
      styles = {
        lazygit = {
          border = "rounded",
        },
      },
    },
    keys = {
      {
        "<leader>g",
        function()
          Snacks.lazygit()
        end,
        desc = "lazygit",
      },
    },
  },
}
