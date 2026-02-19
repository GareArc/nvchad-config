local defaults = require("configs.lsp.defaults")

return defaults.make_config {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayReturnTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayReturnTypeHints = true,
      },
    },
  },
}
