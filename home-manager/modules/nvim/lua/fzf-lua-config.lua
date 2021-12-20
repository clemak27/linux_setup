-- ---------------------------------------- fzf-lua --------------------------------------------------------

local M = {}

M.load = function()

  local actions = require "fzf-lua.actions"

  require'fzf-lua'.setup{
    global_resume = false,
  }

  local opt = {noremap = true, silent = true}

  -- mappings
  vim.api.nvim_set_keymap("n", "<Leader>b", [[<Cmd>lua require('fzf-lua').buffers()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>f", [[<Cmd>lua require('fzf-lua').grep_project()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('fzf-lua').grep_project({rg_opts = "--column --hidden --line-number --no-heading --color=always --smart-case --max-columns=512"})<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>i", [[<Cmd>lua require('fzf-lua').git_status()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>p", [[<Cmd>lua require('fzf-lua').files({ fd_opts = '--color=never --type f --follow --exclude .git', fzf_cli_args = '--keep-right' })<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>pp", [[<Cmd>lua require('fzf-lua').files({ fd_opts = '--color=never --type f --hidden --follow --exclude .git', fzf_cli_args = '--keep-right' })<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>c", [[<Cmd>lua require('fzf-lua').commands()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>cc", [[<Cmd>lua require('fzf-lua').command_history()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>l", [[<Cmd>lua require('fzf-lua').builtin()<CR>]], opt)

  -- lsp mappings
  vim.api.nvim_set_keymap("n", "<Leader>a", [[<Cmd>lua require('fzf-lua').lsp_code_actions()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>d", [[<Cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>dd", [[<Cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>s", [[<Cmd>lua require('fzf-lua').lsp_document_symbols()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<Leader>ss", [[<Cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>]], opt)

end

return M
