return {
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("chezmoi").setup({
        events = {
          on_open = {
            notification = {
              enable = false,
            },
          },
          on_watch = {
            notification = {
              enable = false,
            },
          },
          on_apply = {
            notification = {
              enable = true,
              msg = "Successfully applied",
            },
          },
        },
      })

      vim.api.nvim_create_augroup("chezmoi_watch", { clear = true })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = {
          os.getenv("HOME") .. "/Projects/linux_setup/dotfiles/*",
          "/var" .. os.getenv("HOME") .. "/Projects/linux_setup/dotfiles/*",
        },
        group = "chezmoi_watch",
        callback = function(args)
          local bufnr = args.buf
          local edit_watch = function()
            require("chezmoi.commands.__edit").watch(bufnr)
          end
          vim.schedule(edit_watch)
        end,
      })
    end,
  },
}
