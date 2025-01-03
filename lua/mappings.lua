require "nvchad.mappings"
-- add yours here
local comment = require('Comment')
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
map('i', '<C-z>', '<C-o>u', { desc = 'Undo in insert mode' })
-- Map Ctrl-y for redo in insert mode
map('i', '<C-y>', '<C-o><C-r>', { desc = 'Redo in insert mode' })
-- Map Ctrl+Backspace to delete the word before the cursor in insert mode
map('i', '<C-BS>', '<C-w>', { desc = 'Delete word before cursor in insert mode' })
-- Map Shift+Delete to delete the current line in insert mode
map('i', '<S-Del>', '<Esc>ddi', { desc = 'Delete current line in insert mode' })
-- Move current line up in insert mode with Alt+Up
map('i', '<A-Up>', function()
  vim.cmd('move .-2')
  vim.cmd('normal! ==')
  vim.cmd('startinsert!')
end, { desc = 'Move line up in insert mode' })
-- Move current line down in insert mode with Alt+Down
map('i', '<A-Down>', function()
  vim.cmd('move .+1')
  vim.cmd('normal! ==')
  vim.cmd('startinsert!')
end, { desc = 'Move line down in insert mode' })

-- Normal --
-- Better window navigation
map("n", "<C-Left>", "<C-w>h")
map("n", "<C-Down>", "<C-w>j")
map("n", "<C-Up>", "<C-w>k")
map("n", "<C-Right>", "<C-w>l")
map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })

-- Resize with arrows
map("n", "<C-j>", ":resize +2<CR>")
map("n", "<C-k>", ":resize -2<CR>")
map("n", "<C-l>", ":vertical resize -2<CR>")
map("n", "<C-h>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-Left>", ":bnext<CR>")
map("n", "<S-Right>", ":bprevious<CR>")


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
map("t", "<C-Left>", "<C-\\><C-N><C-w>h")
map("t", "<C-Down>", "<C-\\><C-N><C-w>j")
map("t", "<C-Up>", "<C-\\><C-N><C-w>k")
map("t", "<C-Right>", "<C-\\><C-N><C-w>l")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


-- telescope
local telescope_builtin = require('telescope.builtin')
map('n', '<C-A-p>', telescope_builtin.find_files, { desc = 'Telescope find files' })
map('n', '<C-p>', telescope_builtin.git_files, { desc = 'Telescope find git files' })
map('n', '<C-S-f>', telescope_builtin.grep_string, { desc = 'Telescope grep string' })

-- whichkey
-- map('n', '<leader>?', function()
--   vim.cmd("WhichKey")
-- end, { desc = 'Show which-key menu manually' })

map('n', '<leader>wq', ':q<CR>', { desc = 'Close split window' })

map('n', '<leader>bf', function()
  require('conform').format()
end, { desc = 'Format code with Conform' })

-- Close current buffer with <leader>bq
map('n', '<leader>bq', ':bdelete<CR>', { desc = 'Close current buffer' })

map('n', '<F12>', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Go to implementation' })
map('i', '<F12>', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Go to implementation' })
map('n', '<A-Left>', '<cmd>lua vim.cmd("normal! g;")<CR>', { desc = 'Go to previous cursor position' })
map('n', '<A-Right>', '<cmd>lua vim.cmd("normal! g,")<CR>', { desc = 'Go to next cursor position' })
map('i', '<A-Left>', '<cmd>lua vim.cmd("normal! g;")<CR>', { desc = 'Go to previous cursor position' })
map('i', '<A-Right>', '<cmd>lua vim.cmd("normal! g,")<CR>', { desc = 'Go to next cursor position' })
