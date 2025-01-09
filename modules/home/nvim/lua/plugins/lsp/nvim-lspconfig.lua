-- ---------------------------------------- nvim-lspconfig --------------------------------------------------------
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "barreiroleo/ltex_extra.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            "luvit-meta/library",
          },
        },
      },
      {
        "Bilal2453/luvit-meta",
        lazy = true,
      },
      {
        "stevearc/overseer.nvim",
        config = function()
          require("overseer").setup({
            task_list = {
              min_height = 14,
            },
            component_aliases = {
              -- Most tasks are initialized with the default components
              default = {
                { "display_duration", detail_level = 2 },
                "on_output_summarize",
                "on_exit_set_status",
                "on_complete_notify",
                { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
                { "open_output", on_start = "always" },
              },
              -- Tasks from tasks.json use these components
              default_vscode = {
                "default",
                "on_result_diagnostics",
              },
            },
          })
          local opt = { noremap = true, silent = true }

          vim.api.nvim_set_keymap("n", "<Leader>t", [[<Cmd>OverseerToggle<CR>]], opt)
          vim.api.nvim_set_keymap("n", "<Leader>tr", [[<Cmd>OverseerRun<CR>]], opt)
        end,
      },
      {
        "folke/trouble.nvim",
        config = function()
          require("trouble").setup({})
          local opt = { noremap = true, silent = true }

          vim.api.nvim_set_keymap("n", "<Leader>d", [[<Cmd>Trouble diagnostics toggle<CR>]], opt)
          vim.api.nvim_set_keymap("n", "<Leader>s", [[<Cmd>Trouble lsp_document_symbols toggle<CR>]], opt)
          vim.api.nvim_set_keymap("n", "<Leader>q", [[<Cmd>Trouble quickfix toggle<CR>]], opt)
        end,
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        "bashls",
        "cssls",
        "eslint",
        "gopls",
        "golangci_lint_ls",
        "html",
        "jsonls",
        "jedi_language_server",
        "kotlin_language_server",
        "ltex",
        "nixd",
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "texlab",
        "ts_ls",
        "biome",
        "vimls",
        "volar",
        "yamlls",
      }

      local function setup_servers()
        for _, server in pairs(servers) do
          local config = require("plugins.lsp.util").set_base_config()

          if server == "bashls" then
            config.filetypes = { "bash", "sh", "zsh" }
          end

          if server == "jsonls" then
            config.filetypes = { "json", "json5" }
          end

          if server == "lua_ls" then
            config.cmd = { "lua-language-server" }
            config.settings = {
              Lua = {
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
                ["ui.inlayhint.hints"] = {
                  assignVariableTypes = false,
                  compositeLiteralFields = false,
                  compositeLiteralTypes = false,
                  constantValues = false,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = false,
                },
              },
            }
            vim.lsp.inlay_hint.enable(true)
          end

          if server == "ts_ls" and vim.fn.isdirectory(vim.fn.getcwd() .. "/node_modules/vue") ~= false then
            config.init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  -- npm i --save-dev @vue/typescript-plugin
                  location = os.getenv("HOME") .. "/.local/bin/npm/lib/node_modules/@vue/typescript-plugin",
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            }
            config.filetypes = {
              "javascript",
              "typescript",
              "vue",
            }
          end

          if server == "ltex" then
            config.on_attach = function(client, bufnr)
              local function buf_set_option(...) end

              require("plugins.lsp.util").set_hover_border()
              require("plugins.lsp.util").set_mappings()

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
              config.filetypes = { "imaginaryFiletype" }
            end

            config.settings = {
              ltex = {
                enabled = ltexEnabled,
              },
            }
          end

          if server == "yamlls" then
            config.settings = {
              yaml = {
                keyOrdering = false,
              },
            }
          end

          if server == "nixd" then
            config.settings = {
              nixd = {
                diagnostic = {
                  suppress = {
                    "sema-escaping-with",
                  },
                },
                formatting = {
                  command = { "nixfmt" },
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
      require("lspconfig.ui.windows").default_options.border = require("plugins.lsp.util").rounded_border()
    end,
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.api.nvim_create_user_command("OtterEnable", function()
        require("otter").activate()
      end, {})

      vim.api.nvim_create_user_command("OtterDisable", function()
        require("otter").deactivate()
      end, {})
    end,
  },
}
