-- setup Wezterm
local function base64(data)
  data = tostring(data)
  local bit = require("bit")
  local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  local b64, len = "", #data
  local rshift, lshift, bor = bit.rshift, bit.lshift, bit.bor

  for i = 1, len, 3 do
    local a, b, c = data:byte(i, i + 2)
    b = b or 0
    c = c or 0

    local buffer = bor(lshift(a, 16), lshift(b, 8), c)
    for j = 0, 3 do
      local index = rshift(buffer, (3 - j) * 6) % 64
      b64 = b64 .. b64chars:sub(index + 1, index + 1)
    end
  end

  local padding = (3 - len % 3) % 3
  b64 = b64:sub(1, -1 - padding) .. ("="):rep(padding)

  return b64
end

-- Function to set WezTerm user variable
local function set_wezterm_var(name, value)
  io.write(string.format("\027]1337;SetUserVar=%s=%s\a", name, base64(value)))
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
