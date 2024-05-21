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
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects" },
      })
    end,
  },
  "tpope/vim-fugitive",
}
