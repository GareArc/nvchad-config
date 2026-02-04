-- Mac-specific mappings using Cmd-based keybindings (VSCode Mac shortcuts)
-- Uses <D-...> format for Cmd key (sent by WezTerm)
-- Uses <D-S-...> for Cmd+Shift combinations

local map = vim.keymap.set

-- ============================================================================
-- FILE OPERATIONS (9 shortcuts)
-- ============================================================================

-- Cmd+S: Save file
map("n", "<D-s>", ":w<CR>", { desc = "Save file" })
map("i", "<D-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- Cmd+Shift+S: Save As
map("n", "<D-S-s>", ":saveas<Space>", { desc = "Save As" })

-- Cmd+W: Close editor
map("n", "<D-w>", ":bdelete<CR>", { desc = "Close editor" })
map("i", "<D-w>", "<Esc>:bdelete<CR>", { desc = "Close editor" })

-- Cmd+Shift+W: Close folder
map("n", "<D-S-w>", ":qa<CR>", { desc = "Close folder" })

-- Cmd+N: New file
map("n", "<D-n>", ":enew<CR>", { desc = "New file" })

-- Cmd+O: Open file
map("n", "<D-o>", ":Telescope find_files<CR>", { desc = "Open file" })

-- Cmd+P: Quick open file
map("n", "<D-p>", ":Telescope git_files<CR>", { desc = "Quick open file" })

-- Cmd+Shift+P: Command palette
map("n", "<D-S-p>", ":Telescope commands<CR>", { desc = "Command palette" })

-- Cmd+K Cmd+S: Save all
map("n", "<D-k><D-s>", ":wa<CR>", { desc = "Save all" })

-- ============================================================================
-- SEARCH & REPLACE (7 shortcuts)
-- ============================================================================

-- Cmd+F: Find
map("n", "<D-f>", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Find" })
map("i", "<D-f>", "<Esc>:Telescope current_buffer_fuzzy_find<CR>", { desc = "Find" })

-- Cmd+H: Replace
map("n", "<D-h>", ":Telescope live_grep<CR>", { desc = "Replace" })

-- Cmd+Shift+F: Find in files
map("n", "<D-S-f>", ":Telescope live_grep<CR>", { desc = "Find in files" })

-- Cmd+Shift+H: Replace in files
map("n", "<D-S-h>", ":Telescope live_grep<CR>", { desc = "Replace in files" })

-- Cmd+G: Go to line
map("n", "<D-g>", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Go to line" })

-- F3: Find next
map("n", "<F3>", "n", { desc = "Find next" })

-- Shift+F3: Find previous
map("n", "<S-F3>", "N", { desc = "Find previous" })

-- ============================================================================
-- EDITING (11 shortcuts)
-- ============================================================================

-- Cmd+Z: Undo
map("n", "<D-z>", "u", { desc = "Undo" })
map("i", "<D-z>", "<C-o>u", { desc = "Undo in insert mode" })

-- Cmd+Shift+Z / Cmd+Y: Redo
map("n", "<D-S-z>", "<C-r>", { desc = "Redo" })
map("n", "<D-y>", "<C-r>", { desc = "Redo" })
map("i", "<D-S-z>", "<C-o><C-r>", { desc = "Redo in insert mode" })
map("i", "<D-y>", "<C-o><C-r>", { desc = "Redo in insert mode" })

-- Cmd+X: Cut
map("n", "<D-x>", '"+x', { desc = "Cut" })
map("v", "<D-x>", '"+x', { desc = "Cut selected text" })
map("i", "<D-x>", "<Esc>\"+x", { desc = "Cut" })

-- Cmd+C: Copy (both system clipboard and Neovim register)
map("n", "<D-c>", '"+y', { desc = "Copy" })
map("v", "<D-c>", '"+y', { desc = "Copy selected text" })
map("i", "<D-c>", "<Esc>\"+y", { desc = "Copy" })
-- Also map 'y' for Neovim register
map("n", "y", "y", { desc = "Yank (Neovim register)" })
map("v", "y", "y", { desc = "Yank selected text (Neovim register)" })

-- Cmd+V: Paste (both system clipboard and Neovim register)
map("n", "<D-v>", '"+p', { desc = "Paste" })
map("v", "<D-v>", '"+p', { desc = "Paste text" })
map("i", "<D-v>", "<C-r>+", { desc = "Paste in insert mode" })
-- Also map 'p' for Neovim register
map("n", "p", "p", { desc = "Paste (Neovim register)" })
map("v", "p", '"_dP', { desc = "Paste in visual mode" })

-- Cmd+/: Toggle comment
map("n", "<D-/>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map("v", "<D-/>", function()
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })

-- Cmd+D: Add selection to next find match
map("n", "<D-d>", "*", { desc = "Add selection to next find match" })

-- Cmd+Shift+L: Select all occurrences
map("n", "<D-S-l>", ":%s///g<Left><Left><Left>", { desc = "Select all occurrences" })

-- Cmd+Shift+K: Delete line
map("n", "<D-S-k>", "dd", { desc = "Delete line" })
map("i", "<D-S-k>", "<Esc>ddi", { desc = "Delete line in insert mode" })

-- Cmd+Shift+Up: Move line up
map("i", "<D-S-Up>", function()
  vim.cmd "move .-2"
  vim.cmd "normal! =="
  vim.cmd "startinsert!"
end, { desc = "Move line up in insert mode" })
map("n", "<D-S-Up>", ":move .-2<CR>==", { desc = "Move line up" })

-- Cmd+Shift+Down: Move line down
map("i", "<D-S-Down>", function()
  vim.cmd "move .+1"
  vim.cmd "normal! =="
  vim.cmd "startinsert!"
end, { desc = "Move line down in insert mode" })
map("n", "<D-S-Down>", ":move .+1<CR>==", { desc = "Move line down" })

-- Cmd+Enter: Insert line below
map("n", "<D-CR>", "o<Esc>", { desc = "Insert line below" })
map("i", "<D-CR>", "<Esc>o", { desc = "Insert line below" })

-- Cmd+Shift+Enter: Insert line above
map("n", "<D-S-CR>", "O<Esc>", { desc = "Insert line above" })
map("i", "<D-S-CR>", "<Esc>O", { desc = "Insert line above" })

-- Cmd+[: Decrease indent
map("n", "<D-[>", "<<", { desc = "Decrease indent" })
map("v", "<D-[>", "<gv", { desc = "Decrease indent in visual mode" })
map("i", "<D-[>", "<C-d>", { desc = "Decrease indent in insert mode" })

-- Cmd+]: Increase indent
map("n", "<D-]>", ">>", { desc = "Increase indent" })
map("v", "<D-]>", ">gv", { desc = "Increase indent in visual mode" })
map("i", "<D-]>", "<C-t>", { desc = "Increase indent in insert mode" })

-- ============================================================================
-- NAVIGATION (8 shortcuts)
-- ============================================================================

-- F12: Go to definition
map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("i", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })

-- Cmd+F12: Go to implementation
map("n", "<D-F12>", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })

-- Shift+F12: Go to references
map("n", "<S-F12>", ":Telescope lsp_references<CR>", { desc = "Go to references" })

-- Cmd+Shift+O: Go to symbol in file
map("n", "<D-S-o>", ":Telescope lsp_document_symbols<CR>", { desc = "Go to symbol in file" })

-- Cmd+T: Go to symbol in workspace
map("n", "<D-t>", ":Telescope lsp_workspace_symbols<CR>", { desc = "Go to symbol in workspace" })

-- Cmd+Shift+-: Go back
map("n", "<C-A-D-Left>", "<C-o>", { desc = "Go back" })
map("i", "<C-A-D-Left>", "<C-o>", { desc = "Go back" })

-- Cmd+Shift+=: Go forward (custom mapping)
map("n", "<C-A-D-Right>", "<C-i>", { desc = "Go forward" })
map("i", "<C-A-D-Right>", "<C-i>", { desc = "Go forward" })

-- Cmd+Up: Go to beginning of file
map("n", "<D-Up>", "gg", { desc = "Go to beginning of file" })

-- Cmd+Down: Go to end of file
map("n", "<D-Down>", "G", { desc = "Go to end of file" })

-- ============================================================================
-- WINDOW & VIEW (9 shortcuts)
-- ============================================================================

-- Cmd+B: Toggle sidebar
map("n", "<D-b>", ":NvimTreeToggle<CR>", { desc = "Toggle sidebar" })

-- Cmd+J: Toggle panel
map("n", "<D-j>", ":ToggleTerm<CR>", { desc = "Toggle panel" })

-- Cmd+`: Toggle integrated terminal
map("n", "<D-`>", ":ToggleTerm<CR>", { desc = "Toggle integrated terminal" })

-- Cmd+\: Split editor
map("n", "<D-\\>", ":vsplit<CR>", { desc = "Split editor" })

-- Cmd+K Cmd+\: Split editor orthogonal
map("n", "<D-k><D-\\>", ":split<CR>", { desc = "Split editor orthogonal" })

-- Cmd+1: Focus first editor group
map("n", "<D-1>", "<C-w>1w", { desc = "Focus first editor group" })

-- Cmd+2: Focus second editor group
map("n", "<D-2>", "<C-w>2w", { desc = "Focus second editor group" })

-- Cmd+3: Focus third editor group
map("n", "<D-3>", "<C-w>3w", { desc = "Focus third editor group" })

-- Cmd+Shift+E: Focus file explorer
map("n", "<D-S-e>", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- Cmd+Shift+F: Focus search
map("n", "<D-S-f>", ":Telescope live_grep<CR>", { desc = "Focus search" })

-- Cmd+Shift+G: Focus source control
map("n", "<D-S-g>", ":Telescope git_status<CR>", { desc = "Focus source control" })

-- ============================================================================
-- TAB/BUFFER (5 shortcuts)
-- ============================================================================

-- Cmd+Tab: Open next editor
map("n", "<D-Tab>", ":bnext<CR>", { desc = "Open next editor" })

-- Cmd+Shift+Tab: Open previous editor
map("n", "<D-S-Tab>", ":bprevious<CR>", { desc = "Open previous editor" })

-- Cmd+K Cmd+W: Close all editors
map("n", "<D-k><D-w>", ":qa<CR>", { desc = "Close all editors" })

-- Cmd+K W: Close editor in group
map("n", "<D-k>w", ":bdelete<CR>", { desc = "Close editor in group" })

-- Cmd+Shift+T: Reopen closed editor
map("n", "<D-S-t>", ":e#<CR>", { desc = "Reopen closed editor" })

-- ============================================================================
-- ADDITIONAL UTILITY MAPPINGS
-- ============================================================================

-- Select all
map("n", "<D-a>", "ggVG", { desc = "Select all text in current buffer" })
map("v", "<D-a>", "<Esc>ggVG", { desc = "Select all text in current buffer" })

-- Better window navigation (Cmd+Shift+Arrow)
map("n", "<D-S-Left>", "<C-w>h", { desc = "Navigate window left" })
map("n", "<D-S-Down>", "<C-w>j", { desc = "Navigate window down" })
map("n", "<D-S-Up>", "<C-w>k", { desc = "Navigate window up" })
map("n", "<D-S-Right>", "<C-w>l", { desc = "Navigate window right" })

-- Terminal navigation
map("t", "<D-S-Left>", "<C-\\><C-N><C-w>h", { desc = "Terminal navigate left" })
map("t", "<D-S-Down>", "<C-\\><C-N><C-w>j", { desc = "Terminal navigate down" })
map("t", "<D-S-Up>", "<C-\\><C-N><C-w>k", { desc = "Terminal navigate up" })
map("t", "<D-S-Right>", "<C-\\><C-N><C-w>l", { desc = "Terminal navigate right" })
