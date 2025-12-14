-- ---------------------------------------- treesitter ---------------------------------------------------------
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install("all")

    -- this is not ideal
    local langs = require("nvim-treesitter").get_installed()
    table.insert(langs, "sh")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      callback = function()
        -- syntax highlighting
        vim.treesitter.start()
        -- indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- folds
        -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- vim.wo.foldmethod = "expr"
      end,
    })
  end,
}
