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
          -- other
          "css-lsp",
          "html-lsp",
          "json-lsp",
          "kotlin-language-server",
          "pkl-lsp",

          -- container
          "dockerfile-language-server",

          -- md
          "ltex-ls-plus",

          -- sh
          "bash-language-server",

          -- yaml
          "yaml-language-server",

          -- lua
          "lua-language-server",

          -- go
          "delve",
          "goimports",
          "golangci-lint-langserver",
          "gopls",

          -- java
          "jdtls",
          "gradle-language-server",
          "java-debug-adapter",
          "java-test",

          -- js
          "js-debug-adapter",
          "vue-language-server",
          "typescript-language-server",
          "eslint-lsp",

          -- rust
          "rust-analyzer",

          -- python
          "jedi-language-server",
        },
        auto_update = true,
      })
    end,
  },
}
