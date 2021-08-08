-- ---------------------------------------- java lsp --------------------------------------------------------

local M = {}

M.load = function()

  -- load lsp in java files
  vim.api.nvim_exec(
    [[
    augroup lsp
      au!
      au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp.sh'}})
    augroup end
    ]],
    false)

  require('jdtls.setup').add_commands()
end

return M
