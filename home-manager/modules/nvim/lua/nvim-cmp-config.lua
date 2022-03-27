-- ---------------------------------------- nvim-compe -------------------------------------------------------

local M = {}

M.load = function()

  vim.o.completeopt = "menuone,noselect"
  vim.cmd('set shortmess+=c')

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local lspkind = require('lspkind')
  local cmp = require'cmp'
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i',  's' }),
      ['<s-tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i',  's' }),
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'treesitter' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/`.
  -- cmp.setup.cmdline('/', {
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })

  -- Use cmdline & path source for ':'.
  -- cmp.setup.cmdline(':', {
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

end

return M
