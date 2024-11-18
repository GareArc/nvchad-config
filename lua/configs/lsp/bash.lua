local M = {}

M.setup = function (lspconfig, nvlsp)
  lspconfig["bashls"].setup {
    on_attatch = nvlsp.on_attatch,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

return M

