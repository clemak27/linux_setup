-- ---------------------------------------- nvim-dap ---------------------------------------------------------
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "mxsdev/nvim-dap-vscode-js",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    ft = { "go", "java" },
    config = function()
      require("nvim-dap-virtual-text").setup({})
      require("dapui").setup()

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
        require("nvim-tree.view").close()
        require("overseer").close()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
        require("nvim-tree.view").close()
        require("overseer").close()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.defaults.fallback.switchbuf = "useopen,uselast"

      -- go
      require("dap-go").setup()

      -- java workaround for debugging more complex tests:
      -- 1. start server with gradle --rerun-tasks test --tests "DemoApplicationTests.contextLoads"
      -- 2. attach DAP
      -- for running other tasks, JdtRefreshDebugConfigs and/or JdtTestClass/NearestMethod
      -- https://github.com/microsoft/vscode-java-test/issues/1045
      local util = require("jdtls.util")
      dap.adapters.java = function(callback)
        util.execute_command({ command = "vscode.java.startDebugSession" }, function(err0, port)
          assert(not err0, vim.inspect(err0))
          callback({
            type = "server",
            host = "127.0.0.1",
            port = port,
          })
        end)
      end
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Java attach",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }

      -- dont display separate repl buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function(args)
          vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
        end,
      })

      -- custom signs
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DapIconColor", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapIconColor", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
      )

      local opt = { noremap = true, silent = true }

      -- telescope mappings
      require("telescope").load_extension("dap")
      vim.api.nvim_set_keymap("n", "<Leader>i", [[<Cmd>Telescope dap commands<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<Leader>ic", [[<Cmd>Telescope dap configurations<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<Leader>ib", [[<Cmd>Telescope dap list_breakpoints<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<Leader>iv", [[<Cmd>Telescope dap variables<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<Leader>if", [[<Cmd>Telescope dap frames<CR>]], opt)

      -- dap mappings
      vim.api.nvim_set_keymap("n", "<F5>", [[<Cmd>lua require'dap'.continue()<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<F6>", [[<Cmd>lua require'dap'.step_over()<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<F7>", [[<Cmd>lua require'dap'.step_into()<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<F8>", [[<Cmd>lua require'dap'.step_out()<CR>]], opt)
      vim.api.nvim_set_keymap("n", "<F9>", [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]], opt)
    end,
  },
  "nvim-telescope/telescope-dap.nvim",
}
