-- ---------------------------------------- telescope --------------------------------------------------------
return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
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
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("live_grep_args")

      -- mappings
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>b", builtin.buffers, {})
      vim.keymap.set("n", "<leader>r", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {})

      if os.execute("command -v lg &> /dev/null") == 0 then
        vim.keymap.set("n", "<leader>g", function()
          io.popen("lg")
        end, {})
      end

      vim.keymap.set("n", "<leader>f", function()
        builtin.find_files({ find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" } })
      end, {})

      vim.keymap.set("n", "<leader>c", builtin.commands, {})
      vim.keymap.set("n", "<leader>C", builtin.command_history, {})
      vim.keymap.set("n", "<leader>l", builtin.builtin, {})
      vim.keymap.set("n", "<leader>L", builtin.resume, {})

      -- https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2756267300
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopeFindPre",
        callback = function()
          vim.opt_local.winborder = "none"
          vim.api.nvim_create_autocmd("WinLeave", {
            once = true,
            callback = function()
              vim.opt_local.winborder = "rounded"
            end,
          })
        end,
      })
    end,
  },
}
