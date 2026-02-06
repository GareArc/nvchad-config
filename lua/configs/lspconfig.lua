require("nvchad.configs.lspconfig").defaults()

local defaults = require("configs.lsp.defaults")

vim.lsp.config("html", defaults.make_config {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
})

vim.lsp.config("cssls", defaults.make_config {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
})

require("configs.lsp")

vim.lsp.enable {"html", "cssls"}
