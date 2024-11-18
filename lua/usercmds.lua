local create_cmd = vim.api.nvim_create_user_command

create_cmd("FormatFile", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format files via conform" })
