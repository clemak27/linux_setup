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
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

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

  local servers = {
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "bashls",
    "sumneko_lua",
    "vimls",
    "jdtls",
    "gopls",
    "tsserver",
    "vuels",
    "texlab",
  }

  local function setup_servers()

    for _, server in pairs(servers) do
      local config = make_config()

      local lsp_installer_servers = require'nvim-lsp-installer.servers'

      local server_available, requested_server = lsp_installer_servers.get_server(server)
      if server_available then
        requested_server:on_ready(function ()

          if server == "bashls" then
            config.filetypes = {"bash", "sh", "zsh"};
          end

          if server == "jsonls" then
            config.filetypes = {"json", "json5"}
          end

          if server == "sumneko_lua" then
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            config.cmd = { "lua-language-server" }
            config.settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
                  -- Setup your lua path
                  path = runtime_path,
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = {'vim'},
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              },
            }
          end

          -- java is setup in jdtls-config
          if server ~= "jdtls" then
            requested_server:setup(config)
          end

        end)
        if not requested_server:is_installed() then
          -- Queue the server to be installed
          requested_server:install()
        end
      end
    end
  end

  local function setup_rnix()
    local config = make_config()
    config.filetypes = {"nix"}
    require'lspconfig'["rnix"].setup(config)
  end

  setup_servers()
  setup_rnix()

  -- format golang on edit
  vim.api.nvim_exec(
    [[
    autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting_sync(nil,500)
    ]],
    false)

end

return M
