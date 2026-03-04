vim.lsp.config("pyrefly", require("configs.lsp.servers.pyrefly"))
vim.lsp.config("gopls", require("configs.lsp.servers.gopls"))
vim.lsp.config("bashls", require("configs.lsp.servers.bashls"))
vim.lsp.config("ts_ls", require("configs.lsp.servers.ts_ls"))

vim.lsp.enable {"pyrefly", "gopls", "bashls", "ts_ls"}
