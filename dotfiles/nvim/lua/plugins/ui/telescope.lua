-- ---------------------------------------- telescope --------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "flex",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          mappings = {
            n = {
              ["<f2>"] = require("telescope.actions.layout").toggle_preview,
            },
            i = {
              ["<f2>"] = require("telescope.actions.layout").toggle_preview,
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })

      require("telescope").load_extension("fzf")

      -- mappings
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>b", builtin.buffers, {})
      vim.keymap.set("n", "<leader>r", builtin.live_grep, {})
      -- vim.api.nvim_set_keymap( "n", "<Leader>ff", [[<Cmd>lua require('fzf-lua').grep_project({rg_opts = "--column --hidden --line-number --no-heading --color=always --smart-case --max-columns=512"})<CR>]] , opt

      if os.execute("command -v lg &> /dev/null") == 0 then
        vim.keymap.set("n", "<leader>g", function()
          io.popen("lg")
        end, {})
      end

      vim.keymap.set("n", "<leader>f", builtin.find_files, {})
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } })
      end, {})

      vim.keymap.set("n", "<leader>c", builtin.commands, {})
      vim.keymap.set("n", "<leader>cc", builtin.command_history, {})
      vim.keymap.set("n", "<leader>l", builtin.builtin, {})
      vim.keymap.set("n", "<leader>ll", builtin.resume, {})
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}
