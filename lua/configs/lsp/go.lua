local M = {}

M.setup = function (lspconfig, nvlsp)
  lspconfig["gopls"].setup {
    on_attatch = nvlsp.on_attatch,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    filetypes = {"go","gomod","gowork","gotmpl"},
    root_dir = lspconfig.util.root_pattern("go.work","go.mod",".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          nilness = true,
        },
          staticcheck = true,
      }
    }
  }
end

return M

