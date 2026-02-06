local defaults = require("configs.lsp.defaults")

return defaults.make_config {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  
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
