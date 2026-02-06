local servers = {
  basedpyright = require("configs.lsp.servers.basedpyright"),
  gopls = require("configs.lsp.servers.gopls"),
  bashls = require("configs.lsp.servers.bashls"),
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end
