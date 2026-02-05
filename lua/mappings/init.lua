-- Mappings module with cross-platform support
-- Detects OS and loads platform-specific keybindings

-- Detect operating system
local os_name = vim.uv.os_uname().sysname

-- Check for manual keymap override (useful for SSH from macOS to Linux)
local keymap_override = os.getenv("NVIM_KEYMAP")

-- Load common mappings first (shared across all platforms)
require "mappings.common"

-- Load platform-specific mappings based on override or OS detection
if keymap_override == "mac" then
  -- Override: Force macOS mappings (useful when SSH'ing from Mac)
  require "mappings.mac"
elseif keymap_override == "windows" then
  -- Override: Force Windows/Linux mappings
  require "mappings.windows"
elseif os_name == "Darwin" then
  -- macOS: Space leader-based mappings
  require "mappings.mac"
elseif os_name == "Windows_NT" then
  -- Windows: Ctrl-based mappings
  require "mappings.windows"
else
  -- Linux and other systems: default to Ctrl-based mappings
  require "mappings.windows"
end
