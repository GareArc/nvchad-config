local defaults = require("configs.lsp.defaults")
local util = require("configs.lsp.util")

return defaults.make_config {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = util.root_pattern("pyrightconfig.json", "pyproject.toml", ".git"),
  
  on_new_config = function(config, root_dir)
    local venv_langserver = util.path_join(root_dir, '.venv', 'bin', 'basedpyright-langserver')
    if util.file_readable(venv_langserver) then
      config.cmd = { venv_langserver, '--stdio' }
    end
    
    local python_path = util.get_python_path(root_dir)
    if config.settings and config.settings.basedpyright then
      config.settings.basedpyright.analysis = config.settings.basedpyright.analysis or {}
      config.settings.basedpyright.analysis.pythonPath = python_path
    end
  end,
  
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
