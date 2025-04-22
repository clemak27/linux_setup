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
        setup = function(ctx)
          if vim.fn.exists(":NoMatchParen") ~= 0 then
            vim.cmd([[NoMatchParen]])
          end
          Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
          vim.b.minianimate_disable = true
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
            vim.api.nvim_del_augroup_by_name("numbertoggle")
            vim.o.relativenumber = false
          end)
        end,
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
        terminal = {
          border = "rounded",
        },
      },
      terminal = {
        win = {
          position = "float",
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
