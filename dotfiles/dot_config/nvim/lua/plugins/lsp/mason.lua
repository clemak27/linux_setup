-- ---------------------------------------- mason --------------------------------------------------------
return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- java
          "jdtls",
          "gradle-language-server",
          "java-debug-adapter",
          "java-test",

          -- other
          "clangd",
          "kotlin-lsp",
          "sonarlint-language-server",
          "typescript-language-server",
        },
        auto_update = true,
      })
    end,
  },
}
