local M = {}

M.setup = function(lspconfig, nvlsp)
  lspconfig["pyright"].setup {
    on_attatch = nvlsp.on_attatch,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      python = {
        pythonPath = vim.fn.exepath("python3"),
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  }
end

return M
