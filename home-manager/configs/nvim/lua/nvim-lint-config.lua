-- ---------------------------------------- nvim-lint ------------------------------------------------------------

local M = {}

M.load = function()

  -- set up eslint
  local pattern = [[%s*(%d+):(%d+)%s+(%w+)%s+([%w%s]+)%s+(.*)]]
  local groups = { 'line', 'start_col', 'severity', 'message', 'code' }
  local severity_map = {
    ['error'] = vim.lsp.protocol.DiagnosticSeverity.Error,
    ['warn'] = vim.lsp.protocol.DiagnosticSeverity.Warning,
  }

  require('lint').linters.eslint = {
    cmd = 'eslint',
    args = {},
    stdin = false,
    stream = 'stdout',
    ignore_exitcode = true,
    parser = require('lint.parser').from_pattern(pattern, groups, severity_map, { ['source'] = 'eslint' }),
  }

  require('lint').linters_by_ft = {
    go = {'revive'},
    markdown = {'markdownlint'},
    sh = {'shellcheck'},
    bash = {'shellcheck'},
    zsh = {'shellcheck'},
    javascript = {'eslint'}
  }

  vim.api.nvim_exec(
    [[
    au BufWritePost <buffer> lua require('lint').try_lint()
    ]],
    false
  )

end
return M
