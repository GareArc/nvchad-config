# Installation Guide - Cross-Platform NVChad Configuration

> **For LLM Agents**: This guide is designed for autonomous installation. Follow each step sequentially, checking prerequisites before proceeding.

## Overview

This guide will install a cross-platform NVChad configuration with VSCode-compatible keybindings that automatically adapts to your operating system:
- **macOS**: Cmd-based shortcuts (⌘+S, ⌘+P, etc.)
- **Windows/Linux**: Ctrl-based shortcuts (Ctrl+S, Ctrl+P, etc.)

**Estimated Time**: 15-20 minutes

---

## Prerequisites Check

Before starting, verify the following:

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

### 5. Check Terminal (macOS only)

**If on macOS, ask user**: "Are you using WezTerm, Kitty, Alacritty, iTerm2, or the default Terminal.app?
- (a) WezTerm (Recommended for Cmd key support)
- (b) Kitty
- (c) Alacritty
- (d) iTerm2
- (e) Terminal.app
- (f) Other"

**Note**: For full Cmd key support on macOS, WezTerm, Kitty, or Alacritty with proper configuration is required. If using iTerm2 or Terminal.app, Cmd keys may not work as expected.

---

## Step 1: Install NVChad Base

### 1.1. Clone NVChad Repository

```bash
# Clone NVChad
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

### 2.1. Backup NVChad Starter Files

```bash
# Backup the starter files
cd ~/.config/nvim
mkdir -p .backup
mv lua/mappings.lua .backup/ 2>/dev/null || true
```

---

### 2.2. Clone Custom Configuration Repository

**Ask user**: "What is your GitHub username for the nvchad-config repository? (e.g., 'GareArc')"

```bash
# Set the username variable
GITHUB_USER="<USER_PROVIDED_USERNAME>"

# Clone the custom config repository
git clone https://github.com/$GITHUB_USER/nvchad-config.git /tmp/nvchad-config
```

**If clone fails, ask user**: "The repository could not be cloned. Please verify:
1. The GitHub username is correct
2. The repository is public or you have access
3. Your internet connection is working

Would you like to try again with a different username? (yes/no)"

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
- You're okay with Ctrl-based shortcuts on Mac

**Ask user (macOS only)**: "Would you like to configure WezTerm for Cmd key support? This enables macOS-native shortcuts like Cmd+S, Cmd+P, etc. (yes/no)"

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
- (a) Backup existing config and merge with new Cmd key mappings
- (b) Show me the diff first, then decide
- (c) Skip WezTerm configuration"

#### Backup Existing Config (if user chooses option a):

```bash
cp ~/.wezterm.lua ~/.wezterm.lua.backup.$(date +%Y%m%d_%H%M%S)
echo "Backup created: ~/.wezterm.lua.backup.$(date +%Y%m%d_%H%M%S)"
```

---

### 4.3. Get WezTerm Configuration Template

**Ask user**: "I need to add Cmd key mappings to your WezTerm config. Since the full configuration is not in the repository, I can:
- (a) Provide you with the key mapping code to manually add to your config
- (b) Attempt to automatically merge the mappings (requires reading your current config)
- (c) Skip this step and you'll configure WezTerm later

Which option do you prefer?"

#### Option A: Provide Manual Instructions

**Tell user**:

"Please add the following section to your `~/.wezterm.lua` file. Find the `keys = {` section and add these mappings:

```lua
-- Neovim Cmd key support (add to your keys table)
local nvim_key = function(key, mods, escape_seq)
  return {
    key = key,
    mods = mods,
    action = wezterm.action_callback(function(window, pane)
      if window:get_user_var('IS_NVIM') == 'true' then
        window:perform_action(act.SendString(escape_seq), pane)
      end
    end)
  }
end

-- File Operations
nvim_key('s', 'CMD', '\\x1b[115;3u'),              -- Cmd+S
nvim_key('s', 'CMD|SHIFT', '\\x1b[115;4u'),        -- Cmd+Shift+S
nvim_key('w', 'CMD', '\\x1b[119;3u'),              -- Cmd+W (override WezTerm default)
nvim_key('n', 'CMD', '\\x1b[110;3u'),              -- Cmd+N
nvim_key('o', 'CMD', '\\x1b[111;3u'),              -- Cmd+O
nvim_key('p', 'CMD', '\\x1b[112;3u'),              -- Cmd+P
nvim_key('p', 'CMD|SHIFT', '\\x1b[112;4u'),        -- Cmd+Shift+P

-- Search
nvim_key('f', 'CMD', '\\x1b[102;3u'),              -- Cmd+F (override WezTerm default)
nvim_key('h', 'CMD', '\\x1b[104;3u'),              -- Cmd+H
nvim_key('f', 'CMD|SHIFT', '\\x1b[102;4u'),        -- Cmd+Shift+F
nvim_key('g', 'CMD', '\\x1b[103;3u'),              -- Cmd+G

-- Editing
nvim_key('z', 'CMD', '\\x1b[122;3u'),              -- Cmd+Z
nvim_key('x', 'CMD', '\\x1b[120;3u'),              -- Cmd+X
nvim_key('c', 'CMD', '\\x1b[99;3u'),               -- Cmd+C
nvim_key('v', 'CMD', '\\x1b[118;3u'),              -- Cmd+V
nvim_key('/', 'CMD', '\\x1b[47;3u'),               -- Cmd+/

-- Add more mappings as needed (see full list in documentation)
```

For the complete list of all 50 shortcuts, see: `docs/WEZTERM_CONFIG.md`

After adding these mappings, reload WezTerm or restart it."

---

### 4.4. Verify WezTerm Configuration

```bash
# Test that WezTerm config loads without errors
wezterm cli list --format=json >/dev/null 2>&1 && echo "✓ WezTerm config is valid" || echo "✗ WezTerm config has errors"
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
# Check if Mac mappings are loaded (search for Cmd key mappings)
grep -c "<D-" ~/.config/nvim/lua/mappings/mac.lua
```

**Expected Output**: Should show a number >= 49 (the count of Cmd-based shortcuts)

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

**On macOS**:
- `Cmd+P` - Should open file finder (Telescope)
- `Cmd+S` - Should save file (if file is open)
- `Cmd+/` - Should toggle comment (in a file)

**On Windows/Linux**:
- `Ctrl+P` - Should open file finder (Telescope)
- `Ctrl+S` - Should save file (if file is open)
- `Ctrl+/` - Should toggle comment (in a file)

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

### Issue: "Cmd keys not working on macOS"

**Diagnostic Steps**:

1. **Check WezTerm Configuration**:
```bash
grep -i "IS_NVIM" ~/.wezterm.lua
```

Expected: Should show IS_NVIM user variable configuration.

2. **Check Terminal Type**:
```bash
echo $TERM
```

Expected: Should NOT be `xterm-256color` in WezTerm (should be `wezterm` or similar).

3. **Test Key Detection**:
   - Open Neovim: `nvim`
   - In insert mode, type: `<Ctrl-v>` then press `Cmd+S`
   - Expected: Should see an escape sequence like `^[[115;3u`

**Solution**: If IS_NVIM is not configured, return to Step 4.3 and add the WezTerm configuration.

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

### Issue: "Existing mappings not working"

**Diagnostic Steps**:

1. **Check Which Platform File is Loaded**:
```bash
nvim --headless -c "lua print(vim.uv.os_uname().sysname)" -c "quit" 2>&1 | grep -v "SetUserVar"
```

2. **Check Old mappings.lua**:
```bash
test -f ~/.config/nvim/lua/mappings.lua && echo "Old file exists (should be removed)" || echo "Old file removed (correct)"
```

**Solution**: Ensure old `mappings.lua` is removed or renamed to avoid conflicts.

---

## Installation Complete! 🎉

Your cross-platform NVChad configuration is now installed and ready to use.

**What's Next**:

1. **Read the README**: `cat ~/.config/nvim/README.md` for full feature list
2. **Learn Shortcuts**: All 49 VSCode shortcuts are documented in the README
3. **Customize**: Modify `lua/mappings/common.lua` for personal mappings
4. **Explore Plugins**: Run `:Lazy` to see all installed plugins

**Need Help?**

- Check the troubleshooting section above
- Review logs: `~/.local/state/nvim/log`
- Open an issue on GitHub

**Enjoy your new editor setup!** 🚀
