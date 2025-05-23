-- ---------------------------------------- noice --------------------------------------------------------
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        require("notify").setup({
          background_colour = colors.base,
        })
        vim.notify = require("notify")
      end,
    },
  },
  config = function()
    vim.opt.shortmess:append("IWs")
    vim.o.winborder = "rounded"

    require("noice").setup({
      messages = {
        view_search = false,
      },
      lsp = {
        hover = {
          enabled = false,
        },
        progress = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
              { find = "%d lines changed" },
              { find = "%d lines yanked" },
              { find = "%d buffers wiped out" },
              { find = "Replaced %d line with %d lines" },
              -- this is a workaround for spring-boot.nvim, which fails
              -- to show definitions in java files, and dynamically changing
              -- the handler didn't work
              { find = "'width' key must be a positive Integer" },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            warning = true,
            any = {
              -- Neotest Go sometimes spams this
              { find = "Failed to decode JSON line:" },
            },
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    })
  end,
}
