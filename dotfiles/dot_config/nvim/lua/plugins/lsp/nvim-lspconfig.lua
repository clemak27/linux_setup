-- ---------------------------------------- nvim-lspconfig --------------------------------------------------------
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "barreiroleo/ltex_extra.nvim",
      "https://gitlab.com/schrieveslaach/sonarlint.nvim",
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
        version = "v2.*",
        config = function()
          local overseer = require("overseer")

          overseer.setup({
            task_list = {
              min_height = 14,
            },
          })

          overseer.add_template_hook(nil, function(task_defn, util)
            util.remove_component(task_defn, { "open_output" })
            util.add_component(task_defn, { "open_output", on_start = "always" })
          end)

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
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        on_attach = require("plugins.lsp.util").on_attach,
      })

      vim.lsp.config("bashls", { filetypes = { "bash", "sh", "zsh" } })
      vim.lsp.enable("bashls")

      vim.lsp.enable("biome")
      vim.lsp.enable("cssls")
      vim.lsp.enable("dockerls")
      vim.lsp.enable("eslint")
      vim.lsp.enable("golangci_lint_ls")

      vim.lsp.config("gopls", {
        settings = {
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
        },
      })
      vim.lsp.inlay_hint.enable(true)
      vim.lsp.enable("gopls")

      vim.lsp.enable("gradle_ls")
      vim.lsp.enable("html")
      vim.lsp.enable("jedi_language_server")

      -- this is not 100% correct, but this way jsonls doesn't complain about comments in json5 files
      vim.api.nvim_create_augroup("json5_ft", { clear = true })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.json5",
        group = "json5_ft",
        callback = function()
          vim.api.nvim_exec2("set filetype=jsonc", { output = false })
        end,
      })
      vim.lsp.config("jsonls", { filetypes = { "json", "jsonc", "json5" } })
      vim.lsp.enable("jsonls")

      vim.lsp.enable("kotlin_lsp")

      vim.lsp.config("ltex_plus", {
        on_attach = function(client, bufnr)
          vim.o.winborder = "rounded"
          require("plugins.lsp.util").set_mappings()

          require("ltex_extra").setup({
            load_langs = { "en-GB", "de-DE" },
            init_check = true,
            path = os.getenv("HOME") .. "/.ltex",
          })
        end,
      })
      if os.getenv("NVIM_LTEX_ENABLE") == "false" then
        vim.lsp.config("ltex_plus", { filetypes = { "imaginaryFiletype" } })
      end
      vim.lsp.enable("ltex_plus")

      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        settings = {
          Lua = {
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      if vim.fn.executable("nixd") == 1 then
        vim.lsp.config("nixd", {
          settings = {
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
          },
        })
        vim.lsp.enable("nixd")
      end

      vim.lsp.enable("rumdl")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("taplo")
      vim.lsp.enable("templ")
      vim.lsp.enable("tofu_ls")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("tinymist")
      vim.lsp.enable("ts_ls")

      if vim.fn.isdirectory(vim.fn.getcwd() .. "/node_modules/vue") ~= false then
        vim.lsp.config("ts_ls", {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                -- npm i --save-dev @vue/typescript-plugin
                location = os.getenv("HOME") .. "/.local/bin/npm/lib/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "typescript",
            "vue",
          },
        })
      end

      vim.lsp.enable("vimls")
      vim.lsp.enable("vue_ls")

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            keyOrdering = false,
            editor = {
              formatOnType = false,
            },
          },
        },
      })
      vim.lsp.enable("yamlls")

      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          },
        },
        filetypes = {
          "go",
          "java",
        },
      })

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
