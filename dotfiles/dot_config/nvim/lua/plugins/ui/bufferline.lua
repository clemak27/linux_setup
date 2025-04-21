-- ---------------------------------------- bufferline -------------------------------------------------------
return {
  "akinsho/bufferline.nvim",
  config = function()
    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        right_mouse_command = "vertical sbuffer %d",
        middle_mouse_command = "bdelete! %d",
        diagnostics = false,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thick",
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "NvimTree",
            highlight = "StatusLine",
            separator = false,
          },
        },
        truncate_names = false,
        indicator = {
          style = "none",
        },
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
          },
        },
      },
    })

    local opt = { noremap = true, silent = true }

    -- mappings
    vim.api.nvim_set_keymap("n", "<Leader>1", [[<Cmd>BufferLineGoToBuffer 1<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>2", [[<Cmd>BufferLineGoToBuffer 2<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>3", [[<Cmd>BufferLineGoToBuffer 3<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>4", [[<Cmd>BufferLineGoToBuffer 4<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>5", [[<Cmd>BufferLineGoToBuffer 5<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>6", [[<Cmd>BufferLineGoToBuffer 6<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>7", [[<Cmd>BufferLineGoToBuffer 7<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>8", [[<Cmd>BufferLineGoToBuffer 8<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>9", [[<Cmd>BufferLineGoToBuffer 9<CR>]], opt)

    vim.api.nvim_set_keymap("n", "gb", [[<Cmd>BufferLinePick<CR>]], opt)
    vim.api.nvim_set_keymap("n", "gB", [[<Cmd>BufferLinePickClose<CR>]], opt)
    vim.api.nvim_set_keymap("n", "gn", [[<Cmd>BufferLineCycleNext<CR>]], opt)
    vim.api.nvim_set_keymap("n", "gp", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
    vim.api.nvim_set_keymap("n", "gN", [[<Cmd>BufferLineMoveNext<CR>]], opt)
    vim.api.nvim_set_keymap("n", "gP", [[<Cmd>BufferLineMovePrev<CR>]], opt)
  end,
}
