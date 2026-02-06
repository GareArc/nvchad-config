-- LSP utility functions for Neovim 0.11+
local M = {}

--- Find project root directory by looking for specific files/directories
--- @param markers string|string[] Files/directories to search for (e.g., '.git', 'pyproject.toml')
--- @return function Root directory finder function
function M.root_pattern(...)
  local patterns = vim.tbl_flatten({ ... })
  
  return function(bufnr)
    local fname = type(bufnr) == 'number' and vim.api.nvim_buf_get_name(bufnr) or bufnr
    if fname == '' then
      return nil
    end
    
    local found = vim.fs.find(patterns, {
      upward = true,
      path = vim.fs.dirname(fname),
    })[1]
    
    return found and vim.fs.dirname(found) or nil
  end
end

--- Join path components
--- @param ... string Path components to join
--- @return string Joined path
function M.path_join(...)
  return table.concat({ ... }, "/")
end

--- Check if a file is readable
--- @param filepath string Path to check
--- @return boolean True if file exists and is readable
function M.file_readable(filepath)
  return vim.fn.filereadable(filepath) == 1
end

--- Get Python interpreter path for a project
--- Checks in order: .venv, poetry, pyenv, system python
--- @param workspace string Project root directory
--- @return string Path to Python interpreter
function M.get_python_path(workspace)
  -- Check for .venv first (uv/venv projects)
  local venv_python = M.path_join(workspace, '.venv', 'bin', 'python')
  if M.file_readable(venv_python) then
    return venv_python
  end

  -- Use poetry if pyproject.toml exists
  local pyproject = M.path_join(workspace, 'pyproject.toml')
  if vim.fn.filewritable(pyproject) == 1 then
    local venv = vim.fn.trim(vim.fn.system("poetry env info --path 2>/dev/null"))
    if venv ~= "" and vim.v.shell_error == 0 then
      return M.path_join(venv, 'bin', 'python')
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

return M
