-- ---------------------------------------- nvim-lint ------------------------------------------------------------

local M = {}

M.load = function()

  require('lint').linters_by_ft = {
    go = {'revive'},
    markdown = {'markdownlint'},
    sh = {'shellcheck'},
    bash = {'shellcheck'},
    zsh = {'shellcheck'},
  }

  vim.api.nvim_exec(
    [[
    au BufWritePost <buffer> lua require('lint').try_lint()
    ]],
    false
  )

end
return M
