return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls_config = function()
        local jdtlsHome = os.getenv("HOME") .. "/.jdtls"
        local masonPath = os.getenv("HOME") .. "/.local/share/nvim/mason/packages"
        local jdtlsSource = masonPath .. "/jdtls"
        local lspJar = jdtlsSource .. "/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar"

        local osName = ""
        if vim.loop.os_uname().sysname == "Darwin" then
          osName = "mac"
        else
          osName = "linux"
        end
        local lspConfig = jdtlsSource .. "/config_" .. osName

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = jdtlsHome .. "/workspaces/" .. project_name

        -- local bundlePath = jdtlsHome .. "/bundles"
        local bundles = {
          vim.fn.glob(masonPath .. "/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar"),
        }

        vim.list_extend(bundles, vim.split(vim.fn.glob(masonPath .. "/java-test/*.jar"), "\n"))
        -- vim.list_extend(bundles, vim.split(vim.fn.glob(bundlePath .. "/vscode-spring-boot/jars/*.jar"), "\n"))

        return {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            lspJar,
            "-configuration",
            lspConfig,
            "-data",
            workspace_dir,
          },
          root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
          settings = {
            java = {
              signatureHelp = { enabled = true },
              saveActions = {
                organizeImports = true,
              },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
                filteredTypes = {
                  "com.sun.*",
                  "io.micrometer.shaded.*",
                  "java.awt.*",
                  "jdk.*",
                  "sun.*",
                },
                importOrder = {
                  "at",
                  "com",
                  "org",
                  "javax",
                  "jakarta",
                  "java",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
          on_attach = function(client, bufnr)
            local function buf_set_option(...) end

            vim.o.winborder = "rounded"
            require("plugins.lsp.util").set_mappings()

            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

            vim.lsp.inlay_hint.enable(true)

            vim.api.nvim_create_user_command("JdtTestClass", function()
              require("jdtls").test_class()
            end, {})

            vim.api.nvim_create_user_command("JdtTestNearestMethod", function()
              require("jdtls").test_nearest_method()
            end, {})

            require("jdtls").setup_dap({ hotcodereplace = "auto" })
          end,
          init_options = {
            bundles = bundles,
          },
        }
      end

      vim.api.nvim_create_augroup("jdtls_start", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "java",
        group = "jdtls_start",
        callback = function()
          require("jdtls").start_or_attach(jdtls_config())
        end,
      })
    end,
  },
  -- {
  --   "JavaHello/spring-boot.nvim",
  --   dependencies = {
  --     "mfussenegger/nvim-jdtls",
  --   },
  --   config = function()
  --     vim.g.spring_boot = {
  --       jdt_extensions_path = os.getenv("HOME") .. "/.jdtls/bundles/vscode-spring-boot/jars",
  --     }
  --     require("spring_boot").setup({
  --       ls_path = os.getenv("HOME") .. "/.jdtls/bundles/vscode-spring-boot/language-server",
  --       server = {
  --         handlers = {
  --           ["textDocument/inlayHint"] = function() end,
  --         },
  --       },
  --     })
  --   end,
  -- },
}
