require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt
local o = vim.o
local w = vim.w
local g = vim.g

-- utf8
g.encoding = "UTF-8"
o.fileencoding = "utf-8"

-- indent 2 spaces as one Tab
o.tabstop = 2
vim.bo.tabstop = 2
o.softtabstop = 2
o.shiftround = true

-- search ignore case, except when it contains captical letter 
o.ignorecase = true
o.smartcase = true

-- search while typing
o.incsearch = true

-- always show tabline
o.showtabline = 2

-- clipboard
opt.clipboard = "unnamedplus"

