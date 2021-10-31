-- ---------------------------------------- lspconfig --------------------------------------------------------

local M = {}

M.load = function()

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See :help vim.lsp.* for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<space>u', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  end

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

  local installed_servers = {
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "rnix",
    "bashls",
    "sumneko_lua",
    "vimls",
    -- java is setup in jdtls-config
    "gopls",
    "tsserver",
    "vuels",
    "texlab",
  }

  local function setup_servers()

    for _, server in pairs(installed_servers) do
      local config = make_config()
      local lsp_path = os.getenv('HOME') .. '/.local/bin/nvim/lsp'

      -- language specific config
      if server == "bashls" then
        config.filetypes = {"bash", "sh", "zsh"};
      end

      if server == "html" then
        config.cmd = { "vscode-html-language-server", "--stdio" }
        config.filetypes = {
          -- html
          'aspnetcorerazor',
          'blade',
          'django-html',
          'edge',
          'ejs',
          'eruby',
          'gohtml',
          'haml',
          'handlebars',
          'hbs',
          'html',
          'html-eex',
          'jade',
          'leaf',
          'liquid',
          'markdown',
          'mdx',
          'mustache',
          'njk',
          'nunjucks',
          'php',
          'razor',
          'slim',
          'twig',
          -- mixed
          'vue',
          'svelte',
        }
      end

      if server == "cssls" then
        config.cmd = { "vscode-css-language-server", "--stdio" }
      end

      if server == "jsonls" then
        config.cmd = { "vscode-json-language-server", "--stdio" }
        config.filetypes = {"json", "json5"}
      end

      if server == "sumneko_lua" then
        config.cmd = { "lua-language-server" }
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

  -- format golang on edit
  vim.api.nvim_exec(
    [[
    autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync(nil,500)
    ]],
    false)

end

return M
