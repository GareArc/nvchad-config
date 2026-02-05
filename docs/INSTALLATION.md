# Installation Guide - Cross-Platform NVChad Configuration

> **For LLM Agents**: This guide is designed for autonomous installation. Follow each step sequentially, checking prerequisites before proceeding.

## Overview

This guide will install a cross-platform NVChad configuration with VSCode-style keybindings using **Space as the leader key**:
- **macOS**: Space leader shortcuts (Space+s to save, Space+p to find files, etc.)
- **Windows/Linux**: Ctrl-based shortcuts (Ctrl+S, Ctrl+P, etc.)
- **WezTerm (macOS)**: Native Cmd shortcuts for terminal operations (Cmd+T, Cmd+W, etc.)

> **Note**: Terminals cannot send Cmd/Super keys to applications. This config uses Space as leader in Neovim, while WezTerm handles Cmd shortcuts for terminal-level operations.

**Estimated Time**: 15-20 minutes

---

## Prerequisites Check

Before starting, verify the following:

### 0. Install Required Dependencies

The following tools are required for NvChad to function properly. You'll be asked before installing each one.

#### Required Tools:

**Git** - For cloning repositories
```bash
git --version
```

**Node.js & npm** - For language servers and plugins
```bash
node --version && npm --version
```

**Neovim 0.11+** - The editor itself
```bash
nvim --version
```

**Nerd Font** - For proper icon display in terminal
- Install from https://www.nerdfonts.com/
- Recommended: JetBrainsMono Nerd Font (NOT the Mono variant)
- Set as your terminal font

#### Optional but Recommended Tools:

**Tree-sitter CLI** - Required by nvim-treesitter for syntax highlighting
```bash
tree-sitter --version
```

**Ripgrep** - For fast grep searching with Telescope
```bash
rg --version
```

**GCC/Clang** - For compiling plugins
```bash
gcc --version  # or clang --version
```

**Make** - For building plugins
```bash
make --version
```

**Python 3** - For Python language server and plugins
```bash
python3 --version
```

**Unzip & Tar** - For extracting archives
```bash
unzip -v && tar --version
```

**Clipboard Tools** - For system clipboard integration
- **Linux (X11)**: `xclip` or `xsel`
- **Linux (Wayland)**: `wl-copy` and `wl-paste`
- **macOS**: Built-in (no installation needed)
- **Windows**: Built-in (no installation needed)

**Ask user**: "Would you like me to check for missing dependencies and optionally install them? (yes/no)"

If user says yes, check each tool and ask before installing:
```bash
# Example for macOS
brew install git node neovim ripgrep tree-sitter gcc make python3 unzip

# Example for Ubuntu/Debian
sudo apt update
sudo apt install git nodejs npm neovim ripgrep tree-sitter build-essential python3 unzip

# Example for Arch
sudo pacman -S git nodejs npm neovim ripgrep tree-sitter gcc make python unzip
```

---

### 1. Check Operating System

```bash
# Run this command
uname -s
```

**Expected Output**:
- macOS: `Darwin`
- Linux: `Linux`
- Windows (WSL): `Linux`
- Windows (Git Bash): `MINGW64_NT` or similar

**Question for User**: What operating system are you on? (macOS / Windows / Linux)

---

### 2. Check Neovim Installation

```bash
# Check if Neovim is installed
nvim --version
```

**Expected Output**: `NVIM v0.9.0` or higher

**If NOT installed, ask user**: "Neovim is not installed or version is too old (< 0.9.0). Would you like me to install/upgrade Neovim? (yes/no)"

#### Installation Commands (if user agrees):

**macOS**:
```bash
brew install neovim
```

**Ubuntu/Debian**:
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

**Arch Linux**:
```bash
sudo pacman -S neovim
```

**Windows (via Chocolatey)**:
```bash
choco install neovim
```

**Windows (via Scoop)**:
```bash
scoop install neovim
```

**Verify installation**:
```bash
nvim --version
```

---

### 3. Check Git Installation

```bash
# Check if Git is installed
git --version
```

**Expected Output**: `git version 2.x.x` or higher

**If NOT installed, ask user**: "Git is not installed. Would you like me to install it? (yes/no)"

#### Installation Commands (if user agrees):

**macOS**:
```bash
brew install git
```

**Ubuntu/Debian**:
```bash
sudo apt update
sudo apt install git
```

**Arch Linux**:
```bash
sudo pacman -S git
```

**Windows**: Download from https://git-scm.com/download/win

---

### 4. Check for Existing NVChad Installation

```bash
# Check if NVChad is already installed
ls -la ~/.config/nvim
```

**If directory exists, ask user**: "An existing Neovim configuration was found at ~/.config/nvim. What would you like to do?
- (a) Backup existing config and proceed with installation
- (b) Cancel installation and manually backup
- (c) Overwrite existing config (NOT RECOMMENDED)"

#### Backup Existing Config (if user chooses option a):

```bash
# Backup existing Neovim config
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)
mv ~/.local/state/nvim ~/.local/state/nvim.backup.$(date +%Y%m%d_%H%M%S)
mv ~/.cache/nvim ~/.cache/nvim.backup.$(date +%Y%m%d_%H%M%S)

echo "Backup completed. Old configs saved with timestamp."
```

---

## Step 1: Install NVChad Base

### 1.1. Clone NVChad Starter Repository

```bash
# Clone NVChad starter
git clone https://github.com/NvChad/starter ~/.config/nvim
```

**Verify**:
```bash
ls ~/.config/nvim
```

**Expected Output**: Should show `init.lua`, `lua/` directory, and other NVChad files.

---

### 1.2. Remove .git Directory (Clean Install)

```bash
# Remove .git to prepare for custom config
rm -rf ~/.config/nvim/.git
```

---

### 1.3. Test Base NVChad Installation

```bash
# Start Neovim (it will install plugins automatically)
nvim
```

**What to expect**:
- First launch will install lazy.nvim and all plugins
- This may take 2-5 minutes
- You'll see progress bars for plugin installation
- Once complete, you'll see the NVChad dashboard

**After plugins install, quit Neovim**: Press `:q` and Enter

---

## Step 2: Apply Cross-Platform Configuration

### 2.1. Clone This Custom Configuration Repository

This step clones the nvchad-config repository which contains the cross-platform keybindings and configuration.

```bash
# Clone the custom config repository
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config
```

**Verify**:
```bash
ls /tmp/nvchad-config
```

**Expected Output**: Should show `lua/`, `init.lua`, `docs/`, and other configuration files.

**If clone fails, ask user**: "The repository could not be cloned. Please verify:
1. Your internet connection is working
2. GitHub is accessible
3. The repository URL is correct (https://github.com/GareArc/nvchad-config.git)

Would you like to try again? (yes/no)"

---

### 2.2. Backup NVChad Starter Files

```bash
# Backup the starter files
cd ~/.config/nvim
mkdir -p .backup
mv lua/mappings.lua .backup/ 2>/dev/null || true
```

---

### 2.3. Copy Configuration Files

```bash
# Copy all configuration files
cd /tmp/nvchad-config
cp -r lua ~/.config/nvim/
cp init.lua ~/.config/nvim/
cp -r .stylua.toml ~/.config/nvim/ 2>/dev/null || true

# Clean up temp directory
rm -rf /tmp/nvchad-config
```

**Verify**:
```bash
ls -la ~/.config/nvim/lua/mappings/
```

**Expected Output**: Should show `init.lua`, `common.lua`, `windows.lua`, `mac.lua`

---

### 2.4. Verify Configuration Structure

```bash
# Check that all required files exist
test -f ~/.config/nvim/init.lua && echo "✓ init.lua exists"
test -f ~/.config/nvim/lua/mappings/init.lua && echo "✓ mappings/init.lua exists"
test -f ~/.config/nvim/lua/mappings/windows.lua && echo "✓ mappings/windows.lua exists"
test -f ~/.config/nvim/lua/mappings/mac.lua && echo "✓ mappings/mac.lua exists"
```

**Expected Output**: All 4 checkmarks should appear.

**If any file is missing, ask user**: "Some configuration files are missing. This may cause errors. Would you like to:
- (a) Retry cloning the repository
- (b) Continue anyway (may have errors)
- (c) Cancel installation"

---

## Step 3: Install Language Servers and Tools

### 3.1. Launch Neovim

```bash
nvim
```

---

### 3.2. Install Mason Tools

Once Neovim opens, run:

```vim
:MasonInstallAll
```

**What happens**:
- Mason will install all configured language servers
- This includes LSPs for Python, Go, Bash, JavaScript, etc.
- Installation takes 2-5 minutes depending on your internet speed

**Wait for completion**: You'll see "Mason: Install complete" or similar message.

---

### 3.3. Verify Mason Installation

In Neovim, run:

```vim
:Mason
```

**What to check**:
- Green checkmarks next to installed tools
- No red error messages

Press `q` to close Mason window.

---

### 3.4. Test Basic Functionality

```vim
:checkhealth
```

**What to check**:
- No critical errors (ERROR level)
- Warnings are acceptable
- Pay special attention to:
  - `provider` section (clipboard, Python, Node.js)
  - `nvim-treesitter` section
  - `lspconfig` section

Press `q` to close health check.

---

## Step 4: Configure WezTerm (macOS Only)

**Skip this step if**:
- You're NOT on macOS
- You're NOT using WezTerm

**Ask user (macOS only)**: "Would you like to configure WezTerm for macOS-native terminal shortcuts (Cmd+T for new tab, Cmd+W to close tab, etc.)? (yes/no)"

**If user says no**: Skip to Step 5.

---

### 4.1. Check WezTerm Installation

```bash
# Check if WezTerm is installed
wezterm --version
```

**If NOT installed, ask user**: "WezTerm is not installed. Would you like to install it? (yes/no)"

#### Install WezTerm (if user agrees):

**macOS**:
```bash
brew install --cask wezterm
```

**Verify**:
```bash
wezterm --version
```

---

### 4.2. Check Existing WezTerm Configuration

```bash
# Check if WezTerm config exists
test -f ~/.wezterm.lua && echo "Config exists" || echo "No config found"
```

**If config exists, ask user**: "An existing WezTerm configuration was found at ~/.wezterm.lua. What would you like to do?
- (a) Backup existing config and replace with new config
- (b) Show me the new config first, then decide
- (c) Skip WezTerm configuration"

#### Backup Existing Config (if user chooses option a):

```bash
cp ~/.wezterm.lua ~/.wezterm.lua.backup.$(date +%Y%m%d_%H%M%S)
echo "Backup created: ~/.wezterm.lua.backup.$(date +%Y%m%d_%H%M%S)"
```

---

### 4.3. Create WezTerm Configuration

Create the WezTerm configuration file:

```bash
cat > ~/.wezterm.lua << 'EOF'
local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.window_close_confirmation = 'NeverPrompt'
config.color_scheme = 'Oceanic Next (Gogh)'
config.font = wezterm.font('MesloLGS NF')
config.font_size = 17
config.default_cursor_style = 'BlinkingBar'
config.disable_default_key_bindings = false
config.window_background_opacity = 0.9
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.keys = {
  { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentTab { confirm = true } },
  { key = 'n', mods = 'CMD', action = act.SpawnWindow },
  { key = 'LeftArrow', mods = 'CMD', action = act.SendString '\x1bb' },
  { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x1bf' },
  { key = 'LeftArrow', mods = 'OPT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'OPT', action = act.ActivateTabRelative(1) },
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}

return config
EOF
```

**Verify**:
```bash
wezterm ls-fonts 2>&1 | head -2
```

**Expected Output**: Should show font information without errors.

---

### 4.4. Verify WezTerm Configuration

```bash
# Test that WezTerm config loads without errors
wezterm ls-fonts >/dev/null 2>&1 && echo "✓ WezTerm config is valid" || echo "✗ WezTerm config has errors"
```

**If errors appear, ask user**: "WezTerm configuration has syntax errors. Would you like to:
- (a) Restore the backup config
- (b) Try to fix the errors
- (c) Continue anyway (WezTerm may not work)"

---

## Step 5: Final Verification

### 5.1. Test Neovim Loads Successfully

```bash
# Test that Neovim starts without errors
nvim --headless -c "quit" 2>&1
```

**Expected Output**: Should exit cleanly with no error messages.

**If errors appear**: Note the error message and ask user if they want to continue or troubleshoot.

---

### 5.2. Test OS Detection

```bash
# Test OS detection in Neovim
nvim --headless -c "lua print(vim.uv.os_uname().sysname)" -c "quit" 2>&1 | grep -v "SetUserVar"
```

**Expected Output**:
- macOS: `Darwin`
- Windows: `Windows_NT`
- Linux: `Linux`

---

### 5.3. Test Keybindings Loaded

**For macOS**:
```bash
# Check if Mac mappings are loaded (search for leader key mappings)
grep -c "<leader>" ~/.config/nvim/lua/mappings/mac.lua
```

**Expected Output**: Should show a number >= 15 (the count of leader-based shortcuts)

**For Windows/Linux**:
```bash
# Check if Windows mappings are loaded (search for Ctrl key mappings)
grep -c "<C-" ~/.config/nvim/lua/mappings/windows.lua
```

**Expected Output**: Should show a number >= 49 (the count of Ctrl-based shortcuts)

---

### 5.4. Launch Neovim and Test Basic Shortcuts

```bash
# Launch Neovim
nvim
```

**Test these shortcuts**:

**On macOS (Space leader)**:
- `Space+p` - Should open file finder (Telescope)
- `Space+s` - Should save file (if file is open)
- `Space+/` - Should toggle comment (in a file)
- `Space+e` - Should toggle sidebar (NvimTree)

**On Windows/Linux (Ctrl-based)**:
- `Ctrl+P` - Should open file finder (Telescope)
- `Ctrl+S` - Should save file (if file is open)
- `Ctrl+/` - Should toggle comment (in a file)

**WezTerm (macOS)**:
- `Cmd+T` - Should open new tab
- `Cmd+W` - Should close current tab
- `Cmd+Left/Right` - Should jump by word in shell

**Ask user**: "Did the shortcuts work as expected? (yes/no)"

**If no**: Proceed to troubleshooting section below.

---

## Step 6: Post-Installation Cleanup

### 6.1. Remove Backup Files (Optional)

**Ask user**: "Installation is complete! Would you like to remove the backup files created during installation? (yes/no)

Note: Only do this if everything is working correctly."

```bash
# Remove backups (only if user agrees)
rm -rf ~/.config/nvim.backup.*
rm -rf ~/.local/share/nvim.backup.*
rm -rf ~/.local/state/nvim.backup.*
rm -rf ~/.cache/nvim.backup.*
rm -f ~/.wezterm.lua.backup.*

echo "Backup files removed."
```

---

## Troubleshooting

### Issue: "Space leader shortcuts not working on macOS"

**Diagnostic Steps**:

1. **Check Leader Key Setting**:
```bash
grep "mapleader" ~/.config/nvim/init.lua
```

Expected: Should show `vim.g.mapleader = " "`

2. **Check Mappings File Loaded**:
```bash
grep "<leader>" ~/.config/nvim/lua/mappings/mac.lua | head -5
```

Expected: Should show mappings like `<leader>s`, `<leader>p`, etc.

3. **Test in Neovim**:
   - Open Neovim: `nvim`
   - Press `Space` and wait 1 second
   - You should see which-key popup with available shortcuts

**Solution**: Ensure `vim.g.mapleader = " "` is set BEFORE lazy.nvim loads.

---

### Issue: "WezTerm Cmd shortcuts not working"

**Diagnostic Steps**:

1. **Check WezTerm Configuration**:
```bash
grep "CMD" ~/.wezterm.lua
```

Expected: Should show key bindings with `mods = 'CMD'`.

2. **Reload WezTerm Config**:
   - Press `Cmd+Shift+R` in WezTerm, OR
   - Quit and restart WezTerm

3. **Check for Syntax Errors**:
```bash
wezterm ls-fonts 2>&1 | head -3
```

Expected: Should show font info, not error messages.

**Solution**: If config has errors, restore backup or recreate the config.

---

### Issue: "Module 'mappings' not found"

**Diagnostic Steps**:

1. **Check File Structure**:
```bash
ls -la ~/.config/nvim/lua/mappings/
```

Expected: Should show `init.lua`, `common.lua`, `windows.lua`, `mac.lua`

2. **Check init.lua Integration**:
```bash
grep "require.*mappings" ~/.config/nvim/init.lua
```

Expected: Should show `require "mappings"` in a `vim.schedule` block.

**Solution**: If files are missing, return to Step 2 and re-copy configuration files.

---

### Issue: "LSP not working / No code completion"

**Diagnostic Steps**:

1. **Check Mason Installation**:
```bash
nvim -c "Mason" -c "q"
```

Check that language servers are installed (green checkmarks).

2. **Check LSP Status**:
   - Open a file: `nvim test.py`
   - Run: `:LspInfo`
   - Expected: Should show attached language servers

**Solution**: If LSP not installed, run `:MasonInstallAll` again in Neovim.

---

## Keybinding Reference

### macOS (Space Leader)

| Shortcut | Action |
|----------|--------|
| `Space+s` | Save file |
| `Space+S` | Save all |
| `Space+q` | Quit |
| `Space+Q` | Quit all |
| `Space+p` | Quick open (git files) |
| `Space+P` | Command palette |
| `Space+f` | Find in buffer |
| `Space+F` | Find in files |
| `Space+o` | Open file |
| `Space+r` | Recent files |
| `Space+e` | Toggle sidebar |
| `Space+b` | Focus sidebar |
| `Space+j` | Toggle terminal |
| `Space+/` | Toggle comment |
| `Space+x` | Close buffer |
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space+ld` | Go to definition |
| `Space+lr` | Find references |
| `Space+lf` | Format buffer |
| `Space+la` | Code action |
| `Space+ln` | Rename symbol |

### WezTerm (macOS Terminal)

| Shortcut | Action |
|----------|--------|
| `Cmd+T` | New tab |
| `Cmd+W` | Close tab |
| `Cmd+N` | New window |
| `Cmd+Left` | Jump word left |
| `Cmd+Right` | Jump word right |
| `Opt+Left` | Previous tab |
| `Opt+Right` | Next tab |

### Windows/Linux (Ctrl-based)

| Shortcut | Action |
|----------|--------|
| `Ctrl+S` | Save file |
| `Ctrl+P` | Quick open |
| `Ctrl+F` | Find |
| `Ctrl+/` | Toggle comment |
| ... | (see windows.lua for full list) |

---

## Installation Complete!

Your cross-platform NVChad configuration is now installed and ready to use.

**What's Next**:

1. **Learn Shortcuts**: Press `Space` in Neovim and wait for which-key popup
2. **Customize**: Modify `lua/mappings/common.lua` for personal mappings
3. **Explore Plugins**: Run `:Lazy` to see all installed plugins

**Need Help?**

- Check the troubleshooting section above
- Review logs: `~/.local/state/nvim/log`
- Open an issue on GitHub
