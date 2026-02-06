require("nvchad.configs.lspconfig").defaults()

local defaults = require("configs.lsp.defaults")

local basic_servers = { "html", "cssls" }

for _, name in ipairs(basic_servers) do
  vim.lsp.config(name, defaults.make_config {})
end

require("configs.lsp")
