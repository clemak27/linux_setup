-- ---------------------------------------- telescope --------------------------------------------------------

local M = {}

M.load = function()


  local actions = require('telescope.actions')

  require("telescope").setup {
    defaults = {
      prompt_position ="top",
      mappings = {
        i = {
          ["<esc>"] = actions.close
        },
      },
      sorting_strategy = "ascending",
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'}
    }
  }

  local opt = {noremap = true, silent = true}

  -- mappings
  vim.api.nvim_set_keymap("n", "<Leader>b", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>f", [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>g", [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>r", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>i", [[<Cmd>lua require('telescope.builtin').git_status()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>p", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)

end

return M
