local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local M = {}

M.on_attatch = nvlsp.on_attatch
M.capabilities = nvlsp.capabilities
M.filetypes = {"go","gomod","gowork","gotmpl"}
M.root_dir = lspconfig.util.root_pattern("go.work","go.mod",".git")
M.settings = {
  gopls = {
    analyses = {
      unusedparams = true,
      nilness = true,
    },
    staticcheck = true,
  }
}

return M
