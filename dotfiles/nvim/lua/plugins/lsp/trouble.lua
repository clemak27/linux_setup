return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({})
    local opt = { noremap = true, silent = true }

    vim.api.nvim_set_keymap("n", "<Leader>t", [[<Cmd>TroubleToggle<CR>]], opt)
  end,
}
