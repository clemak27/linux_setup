return {
  rounded_border = function()
    return {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }
  end,

  set_hover_border = function()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = require("plugins.lsp.util").rounded_border(),
    })
  end,

  set_mappings = function()
    local telescope = require("telescope.builtin")
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gd", telescope.lsp_definitions, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gi", telescope.lsp_implementations, bufopts)
    vim.keymap.set("n", "gr", function()
      telescope.lsp_references({ show_line = false })
    end, bufopts)
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "gt", telescope.lsp_type_definitions, bufopts)
    vim.keymap.set("n", "gf", function()
      require("conform").format({
        timeout_ms = 500,
        lsp_fallback = true,
      })
    end, bufopts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
  end,

  on_attach = function(client, bufnr)
    require("plugins.lsp.util").set_hover_border()
    require("plugins.lsp.util").set_mappings()
  end,

  set_base_config = function()
    return {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = require("plugins.lsp.util").on_attach,
    }
  end,
}
