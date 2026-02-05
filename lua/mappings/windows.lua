-- Windows-specific mappings using Ctrl-based keybindings
-- Migrated from lua/mappings.lua and enhanced with VSCode shortcuts

local map = vim.keymap.set

-- ============================================================================
-- EXISTING MAPPINGS (Migrated from lua/mappings.lua)
-- ============================================================================

-- Remap space as leader key
map("", "<Space>", "<Nop>")

-- ============================================================================
-- INSERT MODE MAPPINGS
-- ============================================================================

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

-- ============================================================================
-- NORMAL MODE - BASIC OPERATIONS
-- ============================================================================

map("n", "<C-a>", "ggVG", { desc = "Select all text in current buffer" })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Select all text in current buffer" })

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

-- ============================================================================
-- VISUAL MODE MAPPINGS
-- ============================================================================

-- Stay in indent mode
map("v", "<S-Tab>", "<gv")
map("v", "<Tab>", ">gv")

-- Move text up and down
map("v", "<A-Down>", ":m .+1<CR>==")
map("v", "<A-Up>", ":m .-2<CR>==")
map("v", "p", '"_dP')

-- ============================================================================
-- VISUAL BLOCK MODE MAPPINGS
-- ============================================================================

-- Move text up and down
map("x", "Down", ":move '>+1<CR>gv-gv")
map("x", "Up", ":move '<-2<CR>gv-gv")
map("x", "<A-Down>", ":move '>+1<CR>gv-gv")
map("x", "<A-Up>", ":move '<-2<CR>gv-gv")

-- ============================================================================
-- TERMINAL MODE MAPPINGS
-- ============================================================================

-- Better terminal navigation
map("t", "<C-S-Left>", "<C-\\><C-N><C-w>h", { desc = "Terminal navigate left" })
map("t", "<C-S-Down>", "<C-\\><C-N><C-w>j", { desc = "Terminal navigate down" })
map("t", "<C-S-Up>", "<C-\\><C-N><C-w>k", { desc = "Terminal navigate up" })
map("t", "<C-S-Right>", "<C-\\><C-N><C-w>l", { desc = "Terminal navigate right" })

-- ============================================================================
-- COMMAND MODE MAPPINGS
-- ============================================================================

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ============================================================================
-- TELESCOPE INTEGRATION
-- ============================================================================

local telescope_builtin = require "telescope.builtin"
map("n", "<C-A-p>", telescope_builtin.find_files, { desc = "Telescope find files" })
map("n", "<C-p>", telescope_builtin.git_files, { desc = "Telescope find git files" })
map("n", "<C-S-f>", telescope_builtin.live_grep, { desc = "Telescope live grep" })

-- ============================================================================
-- WINDOW & BUFFER MANAGEMENT
-- ============================================================================

map("n", "<leader>wq", ":q<CR>", { desc = "Close split window" })
map("n", "<leader>bq", ":bdelete<CR>", { desc = "Close current buffer" })

-- ============================================================================
-- CODE FORMATTING
-- ============================================================================

map("n", "<leader>bf", function()
  require("conform").format()
end, { desc = "Format code with Conform" })

-- ============================================================================
-- LSP & NAVIGATION
-- ============================================================================

map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("i", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("n", "<A-Left>", "<C-o>", { desc = "Go to previous cursor position" })
map("n", "<A-Right>", "<C-i>", { desc = "Go to next cursor position" })
map("i", "<A-Left>", "<C-o>", { desc = "Go to previous cursor position" })
map("i", "<A-Right>", "<C-i>", { desc = "Go to next cursor position" })
map("n", "<leader>gr", ":Telescope lsp_references<CR>", { desc = "Show references" })
map("n", "<leader>G", ":Telescope git_status<CR>", { desc = "Git status" })

-- ============================================================================
-- WORD SELECTION
-- ============================================================================

map('i', '<C-S-Left>', '<Esc>vB', { desc = 'Select word to the left' })
map('v', '<C-S-Left>', 'B', { desc = 'Select word to the left in visual mode' })

map('i', '<C-S-Right>', '<Esc>ve', { desc = 'Select word to the right' })
map('v', '<C-S-Right>', 'e', { desc = 'Select word to the right in visual mode' })

map('i', '<C-S-Up>', '<Esc>vk0', { desc = 'Extend selection line up' })
map('v', '<C-S-Up>', 'k0', { desc = 'Extend selection line up in visual mode' })

map('i', '<C-S-Down>', '<Esc>vj$', { desc = 'Select block down' })
map('v', '<C-S-Down>', 'j$', { desc = 'Select block down in visual mode' })

-- ============================================================================
-- CLIPBOARD OPERATIONS
-- ============================================================================

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

-- ============================================================================
-- TEXT WRAPPING
-- ============================================================================

-- Shift + ' to wrap selection with single quotes
map('v', "'", "c'<C-r>\"'<Esc>", { desc = 'Wrap selection with single quotes' })
-- Shift + " to wrap selection with double quotes
map('v', '"', 'c"<C-r>\""<Esc>', { desc = 'Wrap selection with double quotes' })
-- Shift + ( to wrap selection with parentheses
map('v', '(', "c(<C-r>\")<Esc>", { desc = 'Wrap selection with parantheses' })
-- Shift + { to wrap selection with braces
map('v', '{', "c{<C-r>\"}<Esc>", { desc = 'Wrap selection with braces' })

-- ============================================================================
-- SEARCH NAVIGATION
-- ============================================================================

map('n', '<C-S-Up>', 'N', { desc = 'Previous search match' })
map('n', '<C-S-Down>', 'n', { desc = 'Next search match' })

-- ============================================================================
-- NEW VSCODE SHORTCUTS (49 total)
-- ============================================================================

-- FILE OPERATIONS (9)
map("n", "<C-s>", ":w<CR>", { desc = "VSCode: Save file" })
map("i", "<C-s>", "<Esc>:w<CR>", { desc = "VSCode: Save file" })
map("n", "<C-S-s>", ":wa<CR>", { desc = "VSCode: Save all files" })
map("i", "<C-S-s>", "<Esc>:wa<CR>", { desc = "VSCode: Save all files" })
map("n", "<C-w>", ":bdelete<CR>", { desc = "VSCode: Close editor" })
map("i", "<C-w>", "<Esc>:bdelete<CR>", { desc = "VSCode: Close editor" })
map("n", "<C-S-w>", ":qa<CR>", { desc = "VSCode: Close all editors" })
map("i", "<C-S-w>", "<Esc>:qa<CR>", { desc = "VSCode: Close all editors" })
map("n", "<C-n>", ":enew<CR>", { desc = "VSCode: New file" })
map("i", "<C-n>", "<Esc>:enew<CR>", { desc = "VSCode: New file" })
map("n", "<C-o>", ":e<Space>", { desc = "VSCode: Open file" })
map("i", "<C-o>", "<Esc>:e<Space>", { desc = "VSCode: Open file" })
map("n", "<C-S-p>", telescope_builtin.commands, { desc = "VSCode: Command palette" })
map("i", "<C-S-p>", telescope_builtin.commands, { desc = "VSCode: Command palette" })
map("n", "<C-k><C-s>", ":wa<CR>", { desc = "VSCode: Save all (multi-key)" })

-- SEARCH & REPLACE (7)
map("n", "<C-f>", telescope_builtin.current_buffer_fuzzy_find, { desc = "VSCode: Find in file" })
map("i", "<C-f>", telescope_builtin.current_buffer_fuzzy_find, { desc = "VSCode: Find in file" })
map("n", "<C-h>", ":s///g<Left><Left><Left>", { desc = "VSCode: Replace in file" })
map("i", "<C-h>", "<Esc>:s///g<Left><Left><Left>", { desc = "VSCode: Replace in file" })
map("n", "<C-S-f>", telescope_builtin.live_grep, { desc = "VSCode: Find in all files" })
map("n", "<C-S-h>", ":cfdo %s///g<Left><Left><Left>", { desc = "VSCode: Replace in all files" })
map("n", "<C-g>", ":set number<CR>", { desc = "VSCode: Go to line" })
map("i", "<C-g>", "<Esc>:set number<CR>", { desc = "VSCode: Go to line" })
map("n", "<F3>", "n", { desc = "VSCode: Find next" })
map("n", "<S-F3>", "N", { desc = "VSCode: Find previous" })

-- EDITING (11)
map("n", "<C-z>", "u", { desc = "VSCode: Undo" })
map("n", "<C-S-z>", "<C-r>", { desc = "VSCode: Redo" })
map("n", "<C-y>", "<C-r>", { desc = "VSCode: Redo (alternative)" })
map("n", "<C-x>", '"+x', { desc = "VSCode: Cut line" })
map("n", "<C-c>", '"+y', { desc = "VSCode: Copy line" })
map("n", "<C-v>", '"+p', { desc = "VSCode: Paste" })
map("n", "<C-/>", ":normal gcc<CR>", { desc = "VSCode: Toggle line comment" })
map("v", "<C-/>", ":normal gv<CR>:normal gcc<CR>", { desc = "VSCode: Toggle line comment (visual)" })
map("n", "<C-d>", "yy", { desc = "VSCode: Duplicate line" })
map("n", "<C-S-l>", "*", { desc = "VSCode: Select all occurrences" })
map("n", "<C-S-k>", "dd", { desc = "VSCode: Delete line" })
map("n", "<C-S-Up>", ":move .-2<CR>", { desc = "VSCode: Move line up" })
map("n", "<C-S-Down>", ":move .+1<CR>", { desc = "VSCode: Move line down" })
map("n", "<C-Enter>", "o<Esc>", { desc = "VSCode: Insert line below" })
map("n", "<C-S-Enter>", "O<Esc>", { desc = "VSCode: Insert line above" })
map("n", "<C-[>", "<<", { desc = "VSCode: Decrease indent" })
map("n", "<C-]>", ">>", { desc = "VSCode: Increase indent" })

-- NAVIGATION (8)
map("n", "<C-F12>", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "VSCode: Go to type definition" })
map("n", "<C-S-F12>", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "VSCode: Find all references" })
map("n", "<C-S-o>", telescope_builtin.lsp_document_symbols, { desc = "VSCode: Go to symbol in file" })
map("n", "<C-t>", telescope_builtin.lsp_workspace_symbols, { desc = "VSCode: Go to symbol in workspace" })
map("n", "<C-S-->", "<C-o>", { desc = "VSCode: Go back" })
map("n", "<C-Home>", "gg", { desc = "VSCode: Go to start of file" })
map("n", "<C-End>", "G", { desc = "VSCode: Go to end of file" })

-- WINDOW & VIEW (9)
map("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "VSCode: Toggle sidebar" })
map("n", "<C-j>", ":split<CR>", { desc = "VSCode: Toggle panel" })
map("n", "<C-`>", ":terminal<CR>", { desc = "VSCode: Toggle terminal" })
map("n", "<C-\\>", ":vsplit<CR>", { desc = "VSCode: Split editor right" })
map("n", "<C-k><C-\\>", ":vsplit<CR>", { desc = "VSCode: Split editor right (multi-key)" })
map("n", "<C-1>", "1gt", { desc = "VSCode: Focus group 1" })
map("n", "<C-2>", "2gt", { desc = "VSCode: Focus group 2" })
map("n", "<C-3>", "3gt", { desc = "VSCode: Focus group 3" })
map("n", "<C-S-e>", ":NvimTreeToggle<CR>", { desc = "VSCode: Show explorer" })
map("n", "<C-S-f>", telescope_builtin.live_grep, { desc = "VSCode: Show search" })
map("n", "<C-S-g>", ":Telescope git_status<CR>", { desc = "VSCode: Show source control" })

-- TAB/BUFFER (5)
map("n", "<C-Tab>", ":bnext<CR>", { desc = "VSCode: Next editor" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { desc = "VSCode: Previous editor" })
map("n", "<C-k><C-w>", ":bdelete<CR>", { desc = "VSCode: Close editor (multi-key)" })
map("n", "<C-k>w", ":bdelete<CR>", { desc = "VSCode: Close editor (alt multi-key)" })
map("n", "<C-S-t>", ":e#<CR>", { desc = "VSCode: Reopen closed editor" })
