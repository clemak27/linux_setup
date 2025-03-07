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
          "hadolint",
          "html-lsp",
          "json-lsp",
          "kotlin-language-server",
          "prettier",
          "shellcheck",

          -- md
          "markdownlint",
          "ltex-ls",

          -- sh
          "bash-language-server",
          "shfmt",

          -- yaml
          "yaml-language-server",
          "yamllint",
          "yamlfmt",

          -- nix
          "nixpkgs-fmt",

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
      })
    end,
  },
}
