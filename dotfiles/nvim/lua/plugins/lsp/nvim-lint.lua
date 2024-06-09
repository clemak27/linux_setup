-- ---------------------------------------- nvim-lint --------------------------------------------------------
return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local markdownlint = require("lint").linters.markdownlint
      local efm = "stdin:%l:%c %m,stdin:%l %m"
      markdownlint.args = { "--stdin" }
      markdownlint.stdin = true
      markdownlint.append_fname = false
      markdownlint.parser = require("lint.parser").from_errorformat(efm, {
        source = "markdownlint",
        severity = vim.diagnostic.severity.WARN,
      })

      require("lint").linters_by_ft = {
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
        yaml = { "yamllint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
