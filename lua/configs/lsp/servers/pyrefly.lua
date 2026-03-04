local defaults = require("configs.lsp.defaults")
local util = require("configs.lsp.util")

return defaults.make_config {
  cmd = { "pyrefly", "lsp" },
  filetypes = { "python" },
  root_markers = { "pyrefly.toml", "pyproject.toml", ".git" },

  on_new_config = function(config, root_dir)
    -- Prefer venv-local pyrefly if available
    local venv_pyrefly = util.path_join(root_dir, '.venv', 'bin', 'pyrefly')
    if util.file_readable(venv_pyrefly) then
      config.cmd = { venv_pyrefly, 'lsp' }
    end
  end,
}
