-- ---------------------------------------- nvim-dap -----------------------------------------------------------

local M = {}

M.load = function()

  local dap = require('dap')
  local dap_path = os.getenv('HOME') .. '/.local/bin/dev/dap/'

  dap.defaults.fallback.external_terminal = {
    command = dap_path .. 'start_debugger.sh';
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
    args = {dap_path .. 'vscode-node-debug2/out/src/nodeDebug.js'},
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
      request = 'launch',
      name = 'launch jest',
      program = '${workspaceFolder}/node_modules/jest/bin/jest.js',
      args = {
        "-i"
      },
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }

  -- golang
  dap.adapters.go = {
    type = 'executable';
    command = 'node';
    args = {dap_path .. 'vscode-go/dist/debugAdapter.js'};
  }
  dap.configurations.go = {
    {
      type = 'go',
      name = 'Debug',
      request = 'launch',
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath('dlv'),
      console = 'integratedTerminal',
    },
  }

end

return M
