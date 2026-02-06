local defaults = require("configs.lsp.defaults")
local util = require("configs.lsp.util")

return defaults.make_config {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        nilness = true,
      },
      staticcheck = true,
    },
  },
}
