---@brief
---
--- rumdl is a high-performance Markdown linter and formatter that helps
--- ensure consistency and best practices in your Markdown files.
--- Inspired by ruff 's approach to Python linting,
--- rumdl brings similar speed and developer experience improvements
--- to the Markdown ecosystem.
---
--- source: https://github.com/rvben/rumdl

---@type vim.lsp.Config
return {
  cmd = { "rumdl", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".rumdl.toml", ".git" },
}
