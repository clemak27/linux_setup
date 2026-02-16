------------------- core plugins -----------------------------------
return {
  "tpope/vim-repeat",
  "tpope/vim-vinegar",
  {
    "inkarkat/vim-ReplaceWithRegister",
    config = function()
      local opt = { noremap = false, silent = true }
      vim.api.nvim_set_keymap("n", "r", "<Plug>ReplaceWithRegisterOperator", opt)
      vim.api.nvim_set_keymap("n", "rr", "<Plug>ReplaceWithRegisterLine", opt)
      vim.api.nvim_set_keymap("n", "R", "r$", opt)
      vim.api.nvim_set_keymap("x", "r", "<Plug>ReplaceWithRegisterVisual", opt)
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        surrounds = {
          ["C"] = {
            add = { "```", "```" },
          },
        },
        aliases = {
          ["c"] = "`",
        },
      })
    end,
  },
  "antoinemadec/FixCursorHold.nvim",
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      log_level = "error",
      suppressed_dirs = { "~/", "~/Projects" },
      session_lens = {
        load_on_setup = false,
      },
      cwd_change_handling = false,
    },
  },
  {
    "nvim-mini/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup({
        custom_textobjects = {
          -- Whole buffer
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      })
    end,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      local map = require("dial.map")

      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%d.%m.%Y"],
          augend.date.alias["%d.%m."],
          augend.semver.alias.semver,
        },
      })

      vim.keymap.set("n", "<C-a>", function()
        map.manipulate("increment", "normal")
      end)
      vim.keymap.set("n", "<C-x>", function()
        map.manipulate("decrement", "normal")
      end)
      vim.keymap.set("n", "g<C-a>", function()
        map.manipulate("increment", "gnormal")
      end)
      vim.keymap.set("n", "g<C-x>", function()
        map.manipulate("decrement", "gnormal")
      end)
      vim.keymap.set("x", "<C-a>", function()
        map.manipulate("increment", "visual")
      end)
      vim.keymap.set("x", "<C-x>", function()
        map.manipulate("decrement", "visual")
      end)
      vim.keymap.set("x", "g<C-a>", function()
        map.manipulate("increment", "gvisual")
      end)
      vim.keymap.set("x", "g<C-x>", function()
        map.manipulate("decrement", "gvisual")
      end)
    end,
  },
}
