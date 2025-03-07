vim.api.nvim_create_user_command("DapGoDebugTest", function()
  require("dap-go").debug_test()
end, {})

vim.api.nvim_create_user_command("DapGoDebugLastTest", function()
  require("dap-go").debug_last_test()
end, {})
