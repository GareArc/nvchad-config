local options = {
  formatters_by_ft = {
    python = { "isort", "autopep8" },
    go = { "gofmt", "goimports" },
    markdown = { "prettier" },
    ["_"] = { "prettier" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    -- timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
