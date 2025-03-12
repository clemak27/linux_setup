-- ---------------------------------------- neotest --------------------------------------------------------
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "rcasia/neotest-java",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        adapters = {
          require("neotest-golang")({
            dap_go_enabled = true,
          }),
          require("neotest-java")({
            ignore_wrapper = false,
          }),
          require("neotest-jest")({}),
        },
      })

      vim.api.nvim_create_user_command("NeotestRunClosest", function()
        require("neotest").run.run({ suite = false })
      end, {})
      vim.api.nvim_create_user_command("NeotestRunFile", function()
        require("neotest").run.run({ suite = false, vim.fn.expand("%") })
      end, {})
      vim.api.nvim_create_user_command("NeotestDebug", function()
        require("neotest").run.run({ suite = false, strategy = "dap" })
      end, {})
    end,
  },
}
