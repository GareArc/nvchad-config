-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin-latte",
	transparency = false,
}

M.colorscheme = "catppuccin-latte"

M.ui = {
  statusline = {
    theme = "default",
    modules = {
      file = function()
        local stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
        local path = vim.api.nvim_buf_get_name(stbufnr)
        
        if path == "" then
          return "%#St_file# 󰈚 Empty %#St_file_sep#"
        end
        
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --show-toplevel 2>/dev/null")[1]
        local display_path = (git_root and git_root ~= "" and vim.v.shell_error == 0)
          and path:gsub("^" .. vim.pesc(git_root) .. "/", "")
          or vim.fn.fnamemodify(path, ":~:.")
        
        local max_len = math.floor(vim.o.columns * 0.25)
        if #display_path > max_len then
          display_path = "..." .. display_path:sub(-(max_len - 3))
        end
        
        local icon = "󰈚"
        local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
        if devicons_ok then
          local ft_icon = devicons.get_icon(display_path:match("([^/]+)$"))
          icon = ft_icon or icon
        end
        
        return "%#St_file# " .. icon .. " " .. display_path .. " %#St_file_sep#"
      end,
    },
  },
}

M.mason = {
  pkgs = { "pyrefly" },
}

return M
