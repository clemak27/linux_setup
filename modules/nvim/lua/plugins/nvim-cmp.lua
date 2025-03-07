-- ---------------------------------------- nvim-cmp --------------------------------------------------------
return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "enter",
          ["<Tab>"] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
                return require("blink.cmp").select_next()
              end
            end,
            "snippet_forward",
            "fallback",
          },
          ["<S-Tab>"] = {
            "select_prev",
            "snippet_forward",
            "fallback",
          },
        },
        signature = {
          enabled = true,
          window = {
            border = "rounded",
          },
        },
        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
          },
        },
        completion = {
          list = {
            selection = {
              preselect = false,
            },
          },
          keyword = {
            range = "full",
          },
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            draw = {
              columns = {
                { "label", "label_description", gap = 1 },
                { "kind_icon" },
              },
            },
            border = "rounded",
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
            update_delay_ms = 50,
            window = {
              max_width = math.min(80, vim.o.columns),
              border = "rounded",
            },
          },
        },
      })
    end,
  },
}
