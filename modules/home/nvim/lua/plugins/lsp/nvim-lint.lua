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

      local gradleRoot = vim.fs.root(0, "build.gradle")
      if gradleRoot ~= nil then
        local checkstyleCfg = gradleRoot .. "/config/checkstyle/checkstyle.xml"
        local foundConfig = vim.fs.find(checkstyleCfg, { limit = 1, type = "file" })
        if foundConfig[0] ~= nil then
          require("lint").linters.checkstyle.args = { "-c", checkstyleCfg }
          require("lint").linters_by_ft.java = { "checkstyle" }
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
