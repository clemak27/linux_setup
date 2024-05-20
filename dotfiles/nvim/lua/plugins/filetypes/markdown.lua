-- ---------------------------------------- markdown --------------------------------------------------------
return {
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    config = function()
      vim.o.conceallevel = 2
      vim.api.nvim_exec2(
        [[
        let g:vim_markdown_folding_disabled = 1
        let g:vim_markdown_emphasis_multiline = 0
        let g:vim_markdown_conceal_code_blocks = 0
        let g:vim_markdown_new_list_item_indent = 2
        ]],
        { output = false }
      )
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        app = "browser",
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
