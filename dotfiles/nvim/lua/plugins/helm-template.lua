return {
  "towolf/vim-helm",
  ft = { "yaml", "helm" },
  config = function()
    vim.api.nvim_create_augroup("helm_workaround", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      pattern = "*/templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile*.yaml",
      group = "helm_workaround",
      callback = function()
        vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
      end,
    })
  end,
}
