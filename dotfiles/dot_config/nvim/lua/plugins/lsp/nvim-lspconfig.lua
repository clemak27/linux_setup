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
        "apple/pkl-neovim",
        lazy = true,
        ft = "pkl",
        build = function()
          require("pkl-neovim").init()
        end,
        config = function()
          vim.g.pkl_neovim = {
            start_command = { "pkl-lsp" },
          }
        end,
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

          -- https://github.com/stevearc/overseer.nvim/pull/414
          local log = require("overseer.log")
          local overseer = require("overseer")

          local tmpl = {
            priority = 60,
            params = {
              args = { type = "list", delimiter = " " },
              cwd = { optional = true },
            },
            builder = function(params)
              local cmd = { "mise", "run" }
              return {
                args = params.args,
                cmd = cmd,
                cwd = params.cwd,
              }
            end,
          }

          local function get_mise_file(opts)
            local is_misefile = function(name)
              name = name:lower()
              return name == "mise.toml" or name == ".mise.toml"
            end
            return vim.fs.find(is_misefile, { upward = true, path = opts.dir })[1]
          end

          local miseTemplate = {
            name = "mise",
            cache_key = function(opts)
              return get_mise_file(opts)
            end,
            condition = {
              callback = function(opts)
                if vim.fn.executable("mise") == 0 then
                  return false, 'Command "mise" not found'
                end
                if not get_mise_file(opts) then
                  return false, "No mise.toml found"
                end
                return true
              end,
            },
            generator = function(opts, cb)
              local ret = {}
              local jid = vim.fn.jobstart({ "mise", "tasks", "--json" }, {
                stdout_buffered = true,
                on_stdout = vim.schedule_wrap(function(_, output)
                  local ok, data = pcall(vim.json.decode, table.concat(output, ""), { luanil = { object = true } })
                  if not ok then
                    log:error("mise produced invalid json: %s\n%s", data, output)
                    cb(ret)
                    return
                  end
                  assert(data)
                  for _, value in pairs(data) do
                    table.insert(
                      ret,
                      overseer.wrap_template(tmpl, {
                        name = string.format("mise %s", value.name),
                        desc = value.description ~= "" and value.description or nil,
                      }, {
                        args = { value.name },
                        cwd = opts.dir,
                      })
                    )
                  end
                  cb(ret)
                end),
              })
              if jid == 0 then
                log:error('Passed invalid arguments to "mise tasks"')
                cb(ret)
              elseif jid == -1 then
                log:error('"mise" is not executable')
                cb(ret)
              end
            end,
          }

          overseer.register_template(miseTemplate)
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
      {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
          vim.diagnostic.config({ virtual_text = false })
          require("tiny-inline-diagnostic").setup({
            preset = "powerline",
            hi = {
              background = "#121212",
            },
          })
        end,
      },
      {
        "jmbuhr/otter.nvim",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        "bashls",
        "biome",
        "cssls",
        "dockerls",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "gradle_ls",
        "html",
        "jedi_language_server",
        "jsonls",
        "kotlin_language_server",
        "ltex_plus",
        "lua_ls",
        "nixd",
        "rust_analyzer",
        "taplo",
        "terraformls",
        "tailwindcss",
        "tinymist",
        "ts_ls",
        "vimls",
        "volar",
        "yamlls",
      }

      if vim.fn.executable("nixd") == 1 then
        table.insert(servers, "nixd")
      end

      for _, server in pairs(servers) do
        local config = require("plugins.lsp.util").set_base_config()

        if server == "bashls" then
          config.filetypes = { "bash", "sh", "zsh" }
        end

        if server == "jsonls" then
          config.filetypes = { "json", "jsonc", "json5" }
          -- this is not 100% correct, but this way jsonls doesn't complain about comments in json5 files
          vim.api.nvim_create_augroup("json5_ft", { clear = true })
          vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = "*.json5",
            group = "json5_ft",
            callback = function()
              vim.api.nvim_exec2("set filetype=jsonc", { output = false })
            end,
          })
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

        if server == "ltex_plus" then
          config.on_attach = function(client, bufnr)
            vim.o.winborder = "rounded"
            require("plugins.lsp.util").set_mappings()

            require("ltex_extra").setup({
              load_langs = { "en-GB", "de-DE" },
              init_check = true,
              path = os.getenv("HOME") .. "/.ltex",
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
              editor = {
                formatOnType = false,
              },
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

      -- customize signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
    end,
  },
}
