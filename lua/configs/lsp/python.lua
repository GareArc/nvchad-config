local M = {}

local util = require('lspconfig.util')

local function get_python_path(workspace)
  -- Check for .venv first (uv projects)
  local venv_python = util.path.join(workspace, '.venv', 'bin', 'python')
  if vim.fn.filereadable(venv_python) == 1 then
    return venv_python
  end

  -- Use poetry
  if vim.fn.filewritable(util.path.join(workspace, 'pyproject.toml')) == 1 then
    local venv = vim.fn.trim(vim.fn.system("poetry env info --path 2>/dev/null"))
    if venv ~= "" and vim.v.shell_error == 0 then
      return util.path.join(venv, 'bin', 'python')
    end
  end

  -- Fallback to Pyenv global settings
  local pyenv_python = vim.fn.trim(vim.fn.system("pyenv which python 2>/dev/null"))
  if pyenv_python ~= "" and vim.v.shell_error == 0 then
    return pyenv_python
  end

  -- Default system python
  return vim.fn.exepath('python3') or 'python3'
end

M.setup = function(lspconfig, nvlsp)
  lspconfig["basedpyright"].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    on_new_config = function(config, root_dir)
      -- Try to use project's venv basedpyright-langserver if available
      local venv_langserver = util.path.join(root_dir, '.venv', 'bin', 'basedpyright-langserver')
      if vim.fn.filereadable(venv_langserver) == 1 then
        config.cmd = { venv_langserver, '--stdio' }
      end
      
      -- Set Python path
      local python_path = get_python_path(root_dir)
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
    root_dir = util.root_pattern('pyrightconfig.json', 'pyproject.toml', '.git'),
  }
end

return M
