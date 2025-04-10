-- ---------------------------------------- mason --------------------------------------------------------
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
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
          "prettier",

          -- container
          "dockerfile-language-server",
          "hadolint",

          -- md
          "markdownlint",
          "ltex-ls",

          -- sh
          "bash-language-server",
          "shellcheck",
          "shfmt",

          -- yaml
          "yaml-language-server",
          "yamllint",
          "yamlfmt",

          -- lua
          "lua-language-server",
          "stylua",

          -- go
          "delve",
          "gofumpt",
          "goimports",
          "golangci-lint",
          "golangci-lint-langserver",
          "gomodifytags",
          "gopls",

          -- java
          "jdtls",
          "gradle-language-server",
          "java-debug-adapter",
          "java-test",

          -- js
          "biome",
          "js-debug-adapter",
          "vue-language-server",
          "typescript-language-server",
          "eslint-lsp",

          -- rust
          "rust-analyzer",

          -- python
          "jedi-language-server",
          "black",
        },
        auto_update = true,
      })
    end,
  },
}
