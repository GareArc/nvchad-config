-- Mappings module with cross-platform support
-- Detects OS and loads platform-specific keybindings

-- Detect operating system
local os_name = vim.uv.os_uname().sysname

-- Load common mappings first (shared across all platforms)
require "mappings.common"

-- Load platform-specific mappings based on OS detection
if os_name == "Darwin" then
  -- macOS: Cmd-based mappings
  require "mappings.mac"
elseif os_name == "Windows_NT" then
  -- Windows: Ctrl-based mappings
  require "mappings.windows"
else
  -- Linux and other systems: default to Ctrl-based mappings
  require "mappings.windows"
end
