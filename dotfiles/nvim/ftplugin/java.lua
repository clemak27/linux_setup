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
    require("jdtls").organize_imports()
  end, bufopts)
  vim.keymap.set("n", "gR", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
end

local jdtls_config = function()
  local masonPath = vim.fn.stdpath("data") .. "/mason/packages"
  local jdtlsPath = masonPath .. "/jdtls"
  local lspJar = jdtlsPath .. "/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar"
  local osName = ""
  if vim.loop.os_uname().sysname == "Darwin" then
    osName = "mac"
  else
    osName = "linux"
  end
  local lspConfig = jdtlsPath .. "/config_" .. osName

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = os.getenv("HOME") .. "/.jdtls-workspace/" .. project_name

  local bundles = {
    vim.fn.glob(masonPath .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
  }

  vim.list_extend(bundles, vim.split(vim.fn.glob(masonPath .. "/java-test/extension/server/*.jar"), "\n"))

  vim.api.nvim_create_user_command("JdtAddCommands", function()
    require("jdtls.setup").add_commands()
  end, {})

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
        format = {
          settings = {
            url = os.getenv("HOME") .. "/.jdtls-fmt.xml",
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
      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end

      set_border()
      set_mappings()

      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

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

require("jdtls").start_or_attach(jdtls_config())
