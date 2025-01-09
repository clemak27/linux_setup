-- ---------------------------------------- conform --------------------------------------------------------
return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters = {
          shfmt = {
            args = { "-i", "2", "-sr", "-ci", "-filename", "$FILENAME" },
          },
          prettiermd = {
            command = require("conform.formatters.prettier").command,
            cwd = require("conform.formatters.prettier").cwd,
            range_args = require("conform.formatters.prettier").range_args,
            args = {
              "--prose-wrap",
              "always",
              "--stdin-filepath",
              "$FILENAME",
            },
          },
        },
        formatters_by_ft = {
          markdown = { "prettiermd" },
          yaml = { "yamlfmt" },
          lua = { "stylua" },
          nix = { "nixpkgs_fmt" },
          go = { "goimports", "gofumpt" },
          sh = { "shfmt" },
          python = { "black" },
        },
      })

      vim.api.nvim_create_augroup("format_on_write", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.go,*.js,*.ts,*.lua,*.bash,*.sh,*.nix",
        group = "format_on_write",
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            timeout_ms = 500,
            lsp_fallback = true,
          })
        end,
      })
    end,
  },
}
