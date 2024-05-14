-- ---------------------------------------- noice --------------------------------------------------------
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        local stages = require("notify.stages.slide")("top_down")
        require("notify").setup({
          background_colour = "#1e1e2e",
          render = "compact",
          stages = {
            function(...)
              local opts = stages[1](...)
              if opts then
                opts.border = "none"
                opts.row = opts.row + 1
              end
              return opts
            end,
            unpack(stages, 2),
          },
          timeout = 5000,
        })
        vim.notify = require("notify")
      end,
    },
  },
  config = function()
    vim.opt.shortmess:append("IWs")

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
              { find = "Replaced %d line with %d lines" },
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
