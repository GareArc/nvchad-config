require "nvchad.mappings"
-- add yours here
local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Map Ctrl-z for undo in insert mode
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })
-- Map Ctrl-y for redo in insert mode
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo in insert mode" })
-- Map Ctrl+Backspace to delete the word before the cursor in insert mode
map("i", "<C-BS>", "<C-w>", { desc = "Delete word before cursor in insert mode" })
-- Map Shift+Delete to delete the current line in insert mode
map("i", "<S-Del>", "<Esc>ddi", { desc = "Delete current line in insert mode" })
-- Move current line up in insert mode with Alt+Up
map("i", "<A-Up>", function()
  vim.cmd "move .-2"
  vim.cmd "normal! =="
  vim.cmd "startinsert!"
end, { desc = "Move line up in insert mode" })
-- Move current line down in insert mode with Alt+Down
map("i", "<A-Down>", function()
  vim.cmd "move .+1"
  vim.cmd "normal! =="
  vim.cmd "startinsert!"
end, { desc = "Move line down in insert mode" })

map("n", "<C-a>", "ggVG", { desc = "Select all text in current buffer" })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Select all text in current buffer" })

-- Normal --
-- Better window navigation
map("n", "<C-S-Left>", "<C-w>h")
map("n", "<C-S-Down>", "<C-w>j")
map("n", "<C-S-Up>", "<C-w>k")
map("n", "<C-S-Right>", "<C-w>l")
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- Resize with arrows
map("n", "<S-j>", ":resize +2<CR>")
map("n", "<S-k>", ":resize -2<CR>")
map("n", "<S-l>", ":vertical resize -2<CR>")
map("n", "<S-h>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-Right>", ":bnext<CR>")
map("n", "<S-Left>", ":bprevious<CR>")

-- Visual --
-- Stay in indent mode
map("v", "<S-Tab>", "<gv")
map("v", "<Tab>", ">gv")

-- Move text up and down
map("v", "<A-Down>", ":m .+1<CR>==")
map("v", "<A-Up>", ":m .-2<CR>==")
map("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
map("x", "Down", ":move '>+1<CR>gv-gv")
map("x", "Up", ":move '<-2<CR>gv-gv")
map("x", "<A-Down>", ":move '>+1<CR>gv-gv")
map("x", "<A-Up>", ":move '<-2<CR>gv-gv")

-- Terminal --
-- Better terminal navigation
map("t", "<C-S-Left>", "<C-\\><C-N><C-w>h", { desc = "Terminal navigate left" })
map("t", "<C-S-Down>", "<C-\\><C-N><C-w>j", { desc = "Terminal navigate down" })
map("t", "<C-S-Up>", "<C-\\><C-N><C-w>k", { desc = "Terminal navigate up" })
map("t", "<C-S-Right>", "<C-\\><C-N><C-w>l", { desc = "Terminal navigate right" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- telescope
local telescope_builtin = require "telescope.builtin"
map("n", "<C-A-p>", telescope_builtin.find_files, { desc = "Telescope find files" })
map("n", "<C-p>", telescope_builtin.git_files, { desc = "Telescope find git files" })
map("n", "<C-S-f>", telescope_builtin.live_grep, { desc = "Telescope live grep" })

-- whichkey
-- map('n', '<leader>?', function()
--   vim.cmd("WhichKey")
-- end, { desc = 'Show which-key menu manually' })

map("n", "<leader>wq", ":q<CR>", { desc = "Close split window" })

map("n", "<leader>bf", function()
  require("conform").format()
end, { desc = "Format code with Conform" })

-- Close current buffer with <leader>bq
map("n", "<leader>bq", ":bdelete<CR>", { desc = "Close current buffer" })

map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("i", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("n", "<A-Left>", "<C-o>", { desc = "Go to previous cursor position" })
map("n", "<A-Right>", "<C-i>", { desc = "Go to next cursor position" })
map("i", "<A-Left>", "<C-o>", { desc = "Go to previous cursor position" })
map("i", "<A-Right>", "<C-i>", { desc = "Go to next cursor position" })

map("n", "<leader>gr", ":Telescope lsp_references<CR>", { desc = "Show references" })
-- Word Selection
map('i', '<C-S-Left>', '<Esc>vB', { desc = 'Select word to the left' })
map('v', '<C-S-Left>', 'B', { desc = 'Select word to the left in visual mode' })

map('i', '<C-S-Right>', '<Esc>ve', { desc = 'Select word to the right' })
map('v', '<C-S-Right>', 'e', { desc = 'Select word to the right in visual mode' })

map('i', '<C-S-Up>', '<Esc>vk0', { desc = 'Extend selection line up' })
map('v', '<C-S-Up>', 'k0', { desc = 'Extend selection line up in visual mode' })

map('i', '<C-S-Down>', '<Esc>vj$', { desc = 'Select block down' })
map('v', '<C-S-Down>', 'j$', { desc = 'Select block down in visual mode' })

-- Copy, Paste, Cut, Delete, Undo, Redo in visial mode
map('v', '<C-c>', '"+y', { desc = 'Copy selected text' })
map('v', '<C-x>', '"+x', { desc = 'Cut selected text' })
map('v', '<C-v>', '"+p', { desc = 'Paste text' })
map('v', '<BS>', '_d', { desc = 'Delete selected text' })

map('n', 'd', '"_d', { desc = 'Delete without yanking' })
map('v', 'd', '"_d', { desc = 'Delete without yanking' })
-- Disable Ctrl+C in insert mode (acts as an interrupt signal by default)
map('i', '<C-c>', '<Nop>', { desc = 'Disable Ctrl+C in insert mode' })
-- Disable Ctrl+C in command mode (useful if typing a command)
map('c', '<C-c>', '<Nop>', { desc = 'Disable Ctrl+C in command mode' })

-- Shift + ' to wrap selection with single quotes
map('v', "'", "c'<C-r>\"'<Esc>", { desc = 'Wrap selection with single quotes' })
-- Shift + " to wrap selection with double quotes
map('v', '"', 'c"<C-r>\""<Esc>', { desc = 'Wrap selection with double quotes' })
-- Shift + ( to wrap selection with parentheses
map('v', '(', "c(<C-r>\")<Esc>", { desc = 'Wrap selection with parantheses' })
-- Shift + { to wrap selection with braces
map('v', '{', "c{<C-r>\"}<Esc>", { desc = 'Wrap selection with braces' })

-- search nav
map('n', '<C-S-Up>', 'N', { desc = 'Previous search match' })
map('n', '<C-S-Down>', 'n', { desc = 'Next search match' })
