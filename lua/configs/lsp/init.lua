vim.lsp.config("basedpyright", require("configs.lsp.servers.basedpyright"))
vim.lsp.config("gopls", require("configs.lsp.servers.gopls"))
vim.lsp.config("bashls", require("configs.lsp.servers.bashls"))

vim.lsp.enable {"basedpyright", "gopls", "bashls"}
