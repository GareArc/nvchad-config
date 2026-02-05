-- macOS keybindings using Space as leader
-- Leader key is Space (set in init.lua as vim.g.mapleader = " ")

local map = vim.keymap.set

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

map("n", "<leader>s", ":w<CR>", { desc = "Save file" })
map("n", "<leader>S", ":wa<CR>", { desc = "Save all" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================

map("n", "<leader>f", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in buffer" })
map("n", "<leader>F", ":Telescope live_grep<CR>", { desc = "Find in files" })
map("n", "<leader>p", ":Telescope git_files<CR>", { desc = "Quick open file" })
map("n", "<leader>P", ":Telescope commands<CR>", { desc = "Command palette" })
map("n", "<leader>G", ":Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>o", ":Telescope find_files<CR>", { desc = "Open file" })
map("n", "<leader>r", ":Telescope oldfiles<CR>", { desc = "Recent files" })

-- ============================================================================
-- VIEW & SIDEBAR
-- ============================================================================

map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle sidebar" })
map("n", "<leader>b", ":NvimTreeFocus<CR>", { desc = "Focus sidebar" })

-- ============================================================================
-- TERMINAL
-- ============================================================================

map("n", "<leader>j", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle terminal" })

map("n", "<leader>J", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Toggle vertical terminal" })

-- ============================================================================
-- EDITING
-- ============================================================================

map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- ============================================================================
-- CURSOR MOVEMENT (Cmd/Option+Arrow keys via WezTerm escape sequences)
-- ============================================================================

-- Cmd+RightArrow → End of line (WezTerm sends \x05 as <C-e>)
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })
map("n", "<C-e>", "$", { desc = "Move to end of line" })

-- Cmd+LeftArrow → Start of line (WezTerm sends \x01 as <C-a>)
map("i", "<C-a>", "<Home>", { desc = "Move to start of line" })
map("n", "<C-a>", "^", { desc = "Move to start of line" })

-- Option+RightArrow → Forward one word (WezTerm sends \x1bf as <M-f>)
map("i", "<M-f>", "<S-Right>", { desc = "Move forward one word" })
map("n", "<M-f>", "w", { desc = "Move forward one word" })

-- Option+LeftArrow → Back one word (WezTerm sends \x1bb as <M-b>)
map("i", "<M-b>", "<S-Left>", { desc = "Move back one word" })
map("n", "<M-b>", "b", { desc = "Move back one word" })

-- ============================================================================
-- BUFFERS
-- ============================================================================

map("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>X", ":%bdelete<CR>", { desc = "Close all buffers" })
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- ============================================================================
-- LSP (using leader+l prefix)
-- ============================================================================

-- Leader-based LSP bindings
map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>lr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover info" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>ln", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>lf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format buffer" })

-- VSCode-style LSP bindings (F12, Shift+Option+F)
map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition" })
map("i", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("n", "<S-M-f>", ":Telescope lsp_references<CR>", { desc = "Find all references" })

-- ============================================================================
-- JUMP LIST NAVIGATION (Leader+l+arrows)
-- ============================================================================

map("n", "<leader>l<Left>", "<C-o>", { desc = "Go back in jump list" })
map("n", "<leader>l<Right>", "<C-i>", { desc = "Go forward in jump list" })
