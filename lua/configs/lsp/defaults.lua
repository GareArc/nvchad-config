-- Default LSP configuration shared across all servers
-- Provides on_attach, on_init, and capabilities from NvChad

local M = {}

-- Get NvChad's default LSP configuration
local nvchad_lsp = require("nvchad.configs.lspconfig")

-- Export NvChad defaults
M.on_attach = nvchad_lsp.on_attach
M.on_init = nvchad_lsp.on_init
M.capabilities = nvchad_lsp.capabilities

--- Create a base server configuration with NvChad defaults
--- @param overrides table? Optional overrides to merge with defaults
--- @return table Server configuration
function M.make_config(overrides)
  return vim.tbl_deep_extend("force", {
    on_attach = M.on_attach,
    on_init = M.on_init,
    capabilities = M.capabilities,
  }, overrides or {})
end

return M
