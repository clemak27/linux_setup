-- ---------------------------------------- none-ls --------------------------------------------------------
return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      }

      vim.api.nvim_create_user_command("NullLsToggle", function()
        require("null-ls").toggle({})
      end, {})

      null_ls.setup({
        border = border,
        sources = {
          null_ls.builtins.code_actions.gomodifytags,

          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.yamllint,
        },
      })
    end,
  },
}
