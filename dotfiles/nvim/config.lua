-- ---------------------------------------- colorscheme ------------------------------------------------------

require('onedark_custom').setup()

-- ---------------------------------------- lualine ----------------------------------------------------------

local custom_onedark = require'lualine.themes.onedark'
custom_onedark.normal.a.gui = nil
custom_onedark.insert.a.gui = nil
custom_onedark.visual.a.gui = nil
custom_onedark.replace.a.gui = nil
custom_onedark.inactive.a.gui = nil
custom_onedark.normal.b.bg = '#232323'
custom_onedark.normal.c.bg = '#121212'

require('lualine').setup {
  options = {
    theme = custom_onedark,
    section_separators = '',
    component_separators = '|'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {
      {
        'fileformat',
        icon = false
      },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- ---------------------------------------- bufferline -------------------------------------------------------

require("bufferline").setup{
  options = {
    numbers = "ordinal",
    number_style = "",
    mappings = true,
    diagnostics = false,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thick",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
  }
}

-- ---------------------------------------- treesitter -------------------------------------------------------

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = true
  }
}

-- ---------------------------------------- vim-markdown -----------------------------------------------------

vim.api.nvim_exec(
  [[
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_emphasis_multiline = 0
  set conceallevel=2
  ]],
  false
)
-- ---------------------------------------- telescope --------------------------------------------------------

local actions = require('telescope.actions')

require("telescope").setup {
  defaults = {
    prompt_position ="top",
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'}
  }
}

local opt = {noremap = true, silent = true}

-- mappings
vim.api.nvim_set_keymap("n", "<Leader>b", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>f", [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>g", [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>i", [[<Cmd>lua require('telescope.builtin').git_status()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>p", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)

-- ---------------------------------------- lsp --------------------------------------------------------------

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- lspinstall - automatically install language servers
-- run this once

-- require'lspinstall'.install_server("html")
-- require'lspinstall'.install_server("css")
-- require'lspinstall'.install_server("json")
-- require'lspinstall'.install_server("lua")
-- require'lspinstall'.install_server("yaml")
-- require'lspinstall'.install_server("vim")
-- require'lspinstall'.install_server("typescript")
-- require'lspinstall'.install_server("python")
-- require'lspinstall'.install_server("rust")
-- require'lspinstall'.install_server("go")
-- require'lspinstall'.install_server("bash")
-- require'lspinstall'.install_server("vue")
-- require'lspinstall'.install_server("latex")

require'lspinstall'.setup() -- important

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "bash" then
      config.filetypes = {"bash", "sh", "zsh"};
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- nvim-compe

vim.o.completeopt = "menuone,noselect"

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

-- lspkind - additional symbols in completion menu
require('lspkind').init({
  with_text = true,
  preset = 'default',
  symbol_map = {},
})


