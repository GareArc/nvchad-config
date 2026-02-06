require("nvchad.configs.lspconfig").defaults()

local defaults = require("configs.lsp.defaults")

local basic_servers = {
  html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
  },
  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
  },
}

for name, config in pairs(basic_servers) do
  vim.lsp.config(name, defaults.make_config(config))
  vim.lsp.enable(name)
end

require("configs.lsp")
