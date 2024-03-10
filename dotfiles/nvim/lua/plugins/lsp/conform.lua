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
        },
      })
    end,
  },
}
