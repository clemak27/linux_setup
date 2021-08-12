-- ---------------------------------------- nvim-lint ------------------------------------------------------------

local M = {}

M.load = function()

  -- set up eslint
  local esl_pattern = "[^:]+:(%d+):?(%d*): (.*) %[(.*)%]"

  require('lint').linters.eslint = {
    cmd = 'eslint',
    stdin = false,
    args = {"-f", "unix"},
    stream = 'stdout',
    ignore_exitcode = true,
    parser = function(output)
      local diagnostics = {}
      for item in vim.gsplit(output, '\n') do
        local line, column, message, lintCode = string.match(item, esl_pattern)
        if line ~= nil and column ~= nil then
          table.insert(diagnostics, {
            source = 'eslint',
            range = {
              ['start'] = {
                line = tonumber(line) - 1,
                character = tonumber(column) - 1,
              },
              ['end'] = {
                line = tonumber(line) - 1,
                character = tonumber(column),
              },
            },
            message = message,
            code = lintCode,
            severity = vim.lsp.protocol.DiagnosticSeverity.Hint,
          })
        end
      end
      return diagnostics
    end
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
