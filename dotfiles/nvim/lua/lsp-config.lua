-- ---------------------------------------- lspconfig --------------------------------------------------------

local M = {}

M.load = function()

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
  require'lspinstall'.setup()

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

  -- helper function to check if table contains value
  local function table_contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
  end

  -- supported languages LSPs are installed
  local supported_languages = {
    "html",
    "css",
    "json",
    "lua",
    "yaml",
    "vim",
    "typescript",
    "python",
    "rust",
    "go",
    "bash",
    "vue",
    "latex"
  }

  local function setup_servers()
    require'lspinstall'.setup()

    -- get all installed servers
    local servers = require'lspinstall'.installed_servers()

    -- install missing servers
    for _, language in pairs(supported_languages) do
      local installed = table_contains(servers, language)
      if not installed then
        require'lspinstall'.install_server(language)
      end
    end

    for _, server in pairs(servers) do
      local config = make_config()

      -- language specific config
      if server == "bash" then
        config.filetypes = {"bash", "sh", "zsh"};
      end

      if server == "lua" then
        config.root_dir = vim.loop.cwd
        config.settings = {
          Lua = {
            diagnostics = {
              globals = {"vim"}
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
              }
            },
            telemetry = {
              enable = false
            }
          }
        }
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

  -- format golang on edit
  vim.api.nvim_exec(
    [[
    autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync(nil,500)
    ]],
    false)

end

return M
