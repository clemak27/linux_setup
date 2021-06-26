-- ---------------------------------------- nvim-compe -------------------------------------------------------

local M = {}

M.load = function()

  vim.o.completeopt = "menuone,noselect"
  vim.cmd('set shortmess+=c')

  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
      path = true;
      buffer = true;
      calc = true;
      nvim_lsp = true;
      nvim_lua = true;
      vsnip = false;
      ultisnips = false;
    };
  }

-- local opts = { expr=true}
  -- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", opt)

  vim.api.nvim_exec(
    [[
    inoremap <silent><expr> <C-Space> compe#complete()
    inoremap <silent><expr> <CR>      compe#confirm('<CR>')
    inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
    ]],
    false)


-- autocompletion with tab
  -- https://github.com/hrsh7th/nvim-compe/issues/141
  vim.api.nvim_exec(
    [[
    inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    ]],
    false)

end

return M
