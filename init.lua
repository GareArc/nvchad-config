local function set_wezterm_var(name, value)
  value = tostring(value)
  local encoded = vim.base64.encode(value)
  io.write(string.format("\027]1337;SetUserVar=%s=%s\007", name, encoded))
  io.flush()
end

-- Set variable when entering Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    set_wezterm_var("IS_NVIM", "true")
  end,
})

-- Reset variable when exiting Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    set_wezterm_var("IS_NVIM", "false")
  end,
})

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- commands
require "usercmds"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- Load platform-specific keybindings via the mappings module
-- The mappings module (lua/mappings/init.lua) detects the OS and loads:
-- - lua/mappings/common.lua (shared across all platforms)
-- - lua/mappings/mac.lua (macOS with Cmd key)
-- - lua/mappings/windows.lua (Windows/Linux with Ctrl key)
vim.schedule(function()
  require "mappings"
end)

vim.cmd.colorscheme "catppuccin-latte"
