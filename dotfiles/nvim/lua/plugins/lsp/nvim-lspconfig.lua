-- ---------------------------------------- nvim-lspconfig --------------------------------------------------------
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls",
      {
        "someone-stole-my-name/yaml-companion.nvim",
        config = function()
          require("telescope").load_extension("yaml_schema")
        end,
      },
      "barreiroleo/ltex_extra.nvim",
    },
    config = function()
      local set_border = function()
        local border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        }

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = border,
        })
      end

      local set_mappings = function()
        -- See :help vim.lsp.* for documentation on any of the below functions
        local builtin = require("telescope.builtin")
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set("n", "gd", builtin.lsp_definitions, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gr", function()
          builtin.lsp_references({ show_line = false })
        end, bufopts)
        vim.keymap.set("n", "gi", builtin.lsp_implementations, bufopts)
        vim.keymap.set("n", "gt", builtin.lsp_type_definitions, bufopts)
        vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
        vim.keymap.set("n", "gf", function()
          require("conform").format({
            timeout_ms = 500,
            lsp_fallback = true,
          })
        end, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gR", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
      end

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        set_border()
        set_mappings()

        --Enable completion triggered by <c-x><c-o>
        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
      end

      -- config that activates keymaps and enables snippet support
      local function set_base_config()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        return {
          -- enable snippet support
          capabilities = capabilities,
          -- map buffer local keybindings when the language server attaches
          on_attach = on_attach,
        }
      end

      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup()

      local servers = {
        "bashls",
        "cssls",
        "efm",
        "eslint",
        "gopls",
        "golangci_lint_ls",
        "gradle_ls",
        "html",
        -- jdtls is configured in ftplugin/java.lua
        "jsonls",
        "kotlin_language_server",
        "ltex",
        "nil_ls",
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "texlab",
        "tsserver",
        "vimls",
        "volar",
        "yamlls",
      }

      local function setup_servers()
        for _, server in pairs(servers) do
          local config = set_base_config()

          if server == "bashls" then
            config.filetypes = { "bash", "sh", "zsh" }
          end

          if server == "jsonls" then
            config.filetypes = { "json", "json5" }
          end

          if server == "lua_ls" then
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            config.cmd = { "lua-language-server" }
            config.settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                  -- Setup your lua path
                  path = runtime_path,
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
              },
            }
          end

          if server == "gopls" then
            config.settings = {
              gopls = {
                gofumpt = true,
              },
            }
          end

          if server == "gradle_ls" then
            config.settings = {
              gradleWrapperEnabled = true,
            }
          end

          if server == "volar" then
            config.filetypes = {
              "typescript",
              "javascript",
              "javascriptreact",
              "typescriptreact",
              "vue",
              "json",
            }
          end

          if server == "ltex" then
            config.on_attach = function(client, bufnr)
              local function buf_set_option(...)
                vim.api.nvim_buf_set_option(bufnr, ...)
              end

              set_border()
              set_mappings()

              --Enable completion triggered by <c-x><c-o>
              buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

              local configPath = os.getenv("HOME") .. "/.ltex"
              if os.getenv("NVIM_LTEX_LOCAL_CONFIG") == "true" then
                configPath = ".ltex"
              end

              require("ltex_extra").setup({
                load_langs = { "en-US", "de-DE" },
                init_check = true,
                path = configPath,
              })
            end

            local ltexEnabled = true
            if os.getenv("NVIM_LTEX_ENABLE") == "false" then
              ltexEnabled = false
            end

            config.settings = {
              ltex = {
                enabled = ltexEnabled,
              },
            }
          end

          if server == "yamlls" then
            local function loadSchemas(schemaFile)
              local f = io.open(schemaFile)
              if f ~= nil then
                local content = f:read("*all")
                f:close()
                return vim.json.decode(content)
              else
                return {}
              end
            end

            config.settings = {
              yaml = {
                keyOrdering = false,
              },
            }

            local cfg = require("yaml-companion").setup({
              -- additional schemas are loaded from a file like this:
              -- [
              --   {
              --     "name": "argoproj.io/application_v1alpha1",
              --     "uri": "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
              --   }
              -- ]
              schemas = loadSchemas(os.getenv("HOME") .. "/.yaml-schema.json"),
              lspconfig = config,
            })
            lspconfig["yamlls"].setup(cfg)
            return
          end

          if server == "efm" then
            config.filetypes = { "markdown", "dockerfile", "yaml", "sh" }
            config.init_options = { documentFormatting = false }
            config.settings = {
              loglevel = 1,
              languages = {
                markdown = {
                  {
                    lintCommand = "markdownlint --stdin",
                    lintStdin = true,
                    lintIgnoreExitCode = true,
                    lintFormats = {
                      "stdin:%l %m",
                      "stdin:%l:%c %m",
                      "stdin: %l: %m",
                    },
                    lintSeverity = 2,
                  },
                },
                dockerfile = {
                  {
                    lintCommand = "hadolint --no-color -",
                    lintStdin = true,
                    lintIgnoreExitCode = true,
                    lintFormats = { "-:%l %.%# %trror: %m", "-:%l %.%# %tarning: %m", "-:%l %.%# %tnfo: %m" },
                    rootMarkers = { ".hadolint.yaml", "Dockerfile" },
                  },
                },
                yaml = {
                  {
                    lintCommand = "yamllint -f parsable -",
                    lintStdin = true,
                    lintIgnoreExitCode = true,
                    lintFormats = {
                      "%s:%l:%c: [%tarning] %m",
                      "%s:%l:%c: [%trror] %m",
                    },
                  },
                },
                sh = {
                  {
                    lintCommand = "shellcheck --color=never --format=gcc -",
                    lintStdin = true,
                    lintFormats = { "-:%l:%c: %trror: %m", "-:%l:%c: %tarning: %m", "-:%l:%c: %tote: %m" },
                  },
                },
              },
            }
          end

          lspconfig[server].setup(config)
        end
      end

      setup_servers()

      -- customize signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- show borders around lspconfig windows
      require("lspconfig.ui.windows").default_options.border = "single"

      -- format on save
      vim.api.nvim_create_augroup("format_on_write", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*.go,*.js,*.ts,*.lua,*.bash,*.sh,*.nix",
        group = "format_on_write",
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            timeout_ms = 500,
            lsp_fallback = true,
          })
        end,
      })
    end,
  },
}
