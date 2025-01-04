local M = {}

local util = require('lspconfig.util')
local function get_python_path(workspace)
  -- Use poetry
  if vim.fn.filewritable(util.path.join(workspace, 'pyproject.toml')) == 1 then
    local venv = vim.fn.trim(vim.fn.system("poetry env info --path"))
    return util.path.join(venv, 'bin', 'python')
  end

  -- Fallback to Pyenv global settings
  local pyenv_python = vim.fn.trim(vim.fn.system("pyenv which python"))
  if pyenv_python ~= "" then
    return pyenv_python
  end

  -- Default system python
  return vim.fn.exepath('python3') or 'python3'
end

M.setup = function(lspconfig, nvlsp)
  lspconfig["pyright"].setup {
    on_attatch = nvlsp.on_attatch,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
    before_init = function (_, config)
      local cwd = vim.fn.getcwd()
      config.settings.python.pythonPath = get_python_path(cwd)
    end,
  }
end

return M
