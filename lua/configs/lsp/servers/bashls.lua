local defaults = require("configs.lsp.defaults")

return defaults.make_config {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
}
