-- ---------------------------------------- treesitter ---------------------------------------------------------
return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.hurl = {
      install_info = {
        url = "https://github.com/pfeiferj/tree-sitter-hurl.git",
        files = { "src/parser.c" },
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = "hurl",
    }
    parser_config.kdl = {
      install_info = {
        url = "https://github.com/amaanq/tree-sitter-kdl",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
      filetype = "kdl",
    }

    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = false,
      },
      indent = {
        enable = true,
      },
      -- does not compile on macOS
      ignore_install = {
        "phpdoc",
      },
    })
  end,
  build = ":TSUpdate",
}
