-- ---------------------------------------- nvim-dap -----------------------------------------------------------

local M = {}

M.load = function()

  local dap = require('dap')

  dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/alacritty';
    args = {'-e'};
  }
  dap.defaults.fallback.force_external_terminal = true

  local opt = {noremap = true, silent = true}

  -- mappings
  vim.api.nvim_set_keymap("n", "<F5>", [[<Cmd>lua require'dap'.continue()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<F6>", [[<Cmd>lua require'dap'.step_over()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<F7>", [[<Cmd>lua require'dap'.step_into()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<F8>", [[<Cmd>lua require'dap'.step_out()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<F9>", [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]], opt)
  vim.api.nvim_set_keymap("n", "<F12>", [[<Cmd>lua require'dap'.repl.open()<CR>]], opt)

  dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {})

  -- nodejs
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/.local/bin/dap/vscode-node-debug2/out/src/nodeDebug.js'},
  }
  dap.configurations.javascript = {
    {
      type = 'node2',
      request = 'launch',
      name = 'launch',
      program = '${workspaceFolder}/${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      type = 'node2',
      request = 'attach',
      mode = 'remote',
      name = 'attach to jest',
      remotePath = 'localhost:9229',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }

end

return M
