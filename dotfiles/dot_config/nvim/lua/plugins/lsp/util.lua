return {
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
    vim.o.winborder = "rounded"
    require("plugins.lsp.util").set_mappings()
  end,

  set_base_config = function()
    return {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      on_attach = require("plugins.lsp.util").on_attach,
    }
  end,
}
