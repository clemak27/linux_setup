return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "NvimTree*",
      callback = function()
        local api = require("nvim-tree.api")
        local view = require("nvim-tree.view")

        if not view.is_visible() then
          api.tree.open()
        end
      end,
    })

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        adaptive_size = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      update_focused_file = {
        enable = true,
      },
    })

    local opt = { noremap = true, silent = true }

    vim.api.nvim_set_keymap("n", "<Leader>n", [[<Cmd>NvimTreeToggle<CR>]], opt)
  end,
}
