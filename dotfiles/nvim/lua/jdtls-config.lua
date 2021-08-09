-- ---------------------------------------- java lsp --------------------------------------------------------

local M = {}

M.load = function()

  -- load lsp in java files
  vim.api.nvim_exec(
    [[
    augroup lsp
      au!
      au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh', '/home/clemens/.jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')}})
    augroup end
    ]],
    false)

  require('jdtls.setup').add_commands()
end

return M
