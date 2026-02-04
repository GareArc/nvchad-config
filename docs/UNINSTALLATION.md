# Uninstallation Guide - Cross-Platform NVChad Configuration

> **For LLM Agents**: This guide will safely remove the NVChad configuration and restore your system to its previous state.

## Overview

This guide will uninstall the cross-platform NVChad configuration in a safe, step-by-step manner, with options to preserve or remove all components.

**Estimated Time**: 5-10 minutes

---

## Before You Start

### Important Questions

**Ask user**: "What would you like to uninstall?
- (a) Only the custom NVChad configuration (keep NVChad base)
- (b) Complete NVChad installation (remove everything)
- (c) Also remove WezTerm configuration changes
- (d) Full removal including Neovim itself

Please select: a / b / c / d"

**Store the user's choice for later steps.**

---

## Step 1: Backup Before Removal

**Ask user**: "Would you like to create a backup before uninstalling? (yes/no)

Note: Recommended if you might want to reinstall later."

### Create Backup (if user agrees)

```bash
# Create backup directory
BACKUP_DIR=~/nvchad-config-backup-$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR"

# Backup Neovim configuration
cp -r ~/.config/nvim "$BACKUP_DIR/nvim" 2>/dev/null || true

# Backup Neovim data
cp -r ~/.local/share/nvim "$BACKUP_DIR/share-nvim" 2>/dev/null || true

# Backup Neovim state
cp -r ~/.local/state/nvim "$BACKUP_DIR/state-nvim" 2>/dev/null || true

# Backup Neovim cache
cp -r ~/.cache/nvim "$BACKUP_DIR/cache-nvim" 2>/dev/null || true

# Backup WezTerm config (if exists)
cp ~/.wezterm.lua "$BACKUP_DIR/wezterm.lua" 2>/dev/null || true

echo "Backup created at: $BACKUP_DIR"
```

---

## Step 2: Remove Custom NVChad Configuration

### Option A: Remove Only Custom Config (keep NVChad base)

**Execute if user chose option (a)**:

```bash
# Remove custom mapping files
rm -rf ~/.config/nvim/lua/mappings/

# Restore NVChad default mappings (if backup exists)
if [ -f ~/.config/nvim/.backup/mappings.lua ]; then
  mv ~/.config/nvim/.backup/mappings.lua ~/.config/nvim/lua/
  echo "✓ Restored NVChad default mappings"
else
  echo "⚠ No backup of default mappings found"
fi

# Remove custom plugin configurations
rm -f ~/.config/nvim/lua/plugins/nvimtree.lua
rm -f ~/.config/nvim/lua/plugins/conform.lua
rm -f ~/.config/nvim/lua/plugins/comment.lua
rm -f ~/.config/nvim/lua/plugins/font_resize.lua
rm -f ~/.config/nvim/lua/plugins/copilot.lua

# Remove custom configs
rm -rf ~/.config/nvim/lua/configs/lsp/

# Remove custom options
rm -f ~/.config/nvim/lua/options.lua

echo "✓ Custom configuration removed"
echo "NVChad base installation preserved"
```

**Verify**:
```bash
nvim --headless -c "quit" 2>&1
```

**Expected Output**: Neovim should start without errors.

**Skip to Step 4** if user chose option (a).

---

### Option B: Remove Complete NVChad Installation

**Execute if user chose option (b), (c), or (d)**:

```bash
# Remove Neovim configuration directory
rm -rf ~/.config/nvim
echo "✓ Removed ~/.config/nvim"

# Remove Neovim data directory (plugins, mason, etc.)
rm -rf ~/.local/share/nvim
echo "✓ Removed ~/.local/share/nvim"

# Remove Neovim state directory (shada, logs, etc.)
rm -rf ~/.local/state/nvim
echo "✓ Removed ~/.local/state/nvim"

# Remove Neovim cache directory
rm -rf ~/.cache/nvim
echo "✓ Removed ~/.cache/nvim"

echo "✓ Complete NVChad installation removed"
```

**Verify**:
```bash
# Check that directories are removed
ls ~/.config/nvim 2>&1
```

**Expected Output**: `ls: cannot access '~/.config/nvim': No such file or directory`

---

## Step 3: Remove WezTerm Configuration Changes

**Execute if user chose option (c) or (d)**:

**Ask user**: "WezTerm configuration removal has two options:
- (a) Remove only the Neovim Cmd key mappings (preserve other WezTerm settings)
- (b) Remove entire WezTerm configuration
- (c) Skip WezTerm removal

Which option do you prefer?"

---

### Option A: Remove Only Neovim Mappings

**If user has a backup of the original WezTerm config**:

```bash
# Check for backup
ls -la ~/.wezterm.lua.backup.* 2>/dev/null

# If backup exists, ask which one to restore
echo "Available backups:"
ls -la ~/.wezterm.lua.backup.*

# Let user choose or restore the most recent
LATEST_BACKUP=$(ls -t ~/.wezterm.lua.backup.* 2>/dev/null | head -1)

if [ -n "$LATEST_BACKUP" ]; then
  cp "$LATEST_BACKUP" ~/.wezterm.lua
  echo "✓ Restored WezTerm config from: $LATEST_BACKUP"
else
  echo "⚠ No backup found. Manual removal required."
  echo "Please edit ~/.wezterm.lua and remove the Neovim Cmd key mapping sections."
fi
```

**If no backup exists**:

**Tell user**:
"No WezTerm backup was found. You'll need to manually edit `~/.wezterm.lua` and remove the following sections:

1. The `nvim_key` function definition
2. All key mappings that use `nvim_key()` or check for `IS_NVIM`
3. The `IS_NVIM` user variable setup in autocmds

Alternatively, you can delete the entire config and WezTerm will use defaults:
```bash
rm ~/.wezterm.lua
```"

---

### Option B: Remove Entire WezTerm Config

```bash
# Remove WezTerm configuration
rm -f ~/.wezterm.lua
echo "✓ Removed ~/.wezterm.lua"

# Remove WezTerm data (optional)
# Ask user first: "Also remove WezTerm data/cache? (yes/no)"
# If yes:
rm -rf ~/.local/share/wezterm 2>/dev/null || true
rm -rf ~/.cache/wezterm 2>/dev/null || true
echo "✓ Removed WezTerm data and cache"
```

**Verify**:
```bash
test -f ~/.wezterm.lua && echo "Config still exists" || echo "✓ Config removed"
```

---

## Step 4: Remove Neovim (Optional)

**Execute if user chose option (d)**:

**Ask user**: "Are you sure you want to completely remove Neovim? This will uninstall the Neovim application itself. (yes/no)"

**If user confirms**:

```bash
# Detect package manager and remove Neovim

# macOS (Homebrew)
if command -v brew >/dev/null 2>&1; then
  brew uninstall neovim
  echo "✓ Uninstalled Neovim via Homebrew"
fi

# Ubuntu/Debian
if command -v apt >/dev/null 2>&1; then
  sudo apt remove --purge neovim
  sudo apt autoremove
  echo "✓ Uninstalled Neovim via apt"
fi

# Arch Linux
if command -v pacman >/dev/null 2>&1; then
  sudo pacman -Rns neovim
  echo "✓ Uninstalled Neovim via pacman"
fi

# Verify removal
command -v nvim >/dev/null 2>&1 && echo "⚠ Neovim still found in PATH" || echo "✓ Neovim removed"
```

---

## Step 5: Clean Up Backup Files

**Ask user**: "Uninstallation is complete. Would you like to:
- (a) Keep all backup files (in case you need to restore)
- (b) Remove old backup files (created during installation, not the one from Step 1)
- (c) Remove ALL backup files including the one from Step 1

Which option do you prefer?"

---

### Option B: Remove Old Installation Backups

```bash
# Remove backups created during installation
rm -rf ~/.config/nvim.backup.*
rm -rf ~/.local/share/nvim.backup.*
rm -rf ~/.local/state/nvim.backup.*
rm -rf ~/.cache/nvim.backup.*
rm -f ~/.wezterm.lua.backup.*

echo "✓ Old backup files removed"
echo "✓ Backup from Step 1 preserved at: $BACKUP_DIR"
```

---

### Option C: Remove ALL Backups

```bash
# Remove ALL backup files
rm -rf ~/.config/nvim.backup.*
rm -rf ~/.local/share/nvim.backup.*
rm -rf ~/.local/state/nvim.backup.*
rm -rf ~/.cache/nvim.backup.*
rm -f ~/.wezterm.lua.backup.*
rm -rf ~/nvchad-config-backup-*

echo "✓ All backup files removed"
```

---

## Step 6: Verification

### 6.1. Verify NVChad Removal

```bash
# Check if config directory is removed
test -d ~/.config/nvim && echo "⚠ Config directory still exists" || echo "✓ Config removed"

# Check if data directory is removed
test -d ~/.local/share/nvim && echo "⚠ Data directory still exists" || echo "✓ Data removed"

# Check if state directory is removed
test -d ~/.local/state/nvim && echo "⚠ State directory still exists" || echo "✓ State removed"

# Check if cache directory is removed
test -d ~/.cache/nvim && echo "⚠ Cache directory still exists" || echo "✓ Cache removed"
```

---

### 6.2. Verify WezTerm Config Removal (if applicable)

```bash
# Check if WezTerm config is removed/restored
test -f ~/.wezterm.lua && echo "Config exists (restored or not removed)" || echo "✓ Config removed"

# If config exists, check if it still has Neovim mappings
if [ -f ~/.wezterm.lua ]; then
  grep -q "IS_NVIM" ~/.wezterm.lua && echo "⚠ Neovim mappings still present" || echo "✓ Neovim mappings removed"
fi
```

---

### 6.3. Verify Neovim Removal (if applicable)

```bash
# Check if Neovim is removed
command -v nvim >/dev/null 2>&1 && echo "⚠ Neovim still installed" || echo "✓ Neovim removed"

# Check version if still installed
nvim --version 2>/dev/null | head -1
```

---

## Restoration Instructions

If you backed up your configuration in Step 1, you can restore it later:

### Restore NVChad Configuration

```bash
# Find your backup directory
ls -d ~/nvchad-config-backup-* | tail -1

# Set the backup directory (use the output from above)
BACKUP_DIR="<path_from_above>"

# Restore Neovim configuration
cp -r "$BACKUP_DIR/nvim" ~/.config/nvim

# Restore Neovim data
cp -r "$BACKUP_DIR/share-nvim" ~/.local/share/nvim

# Restore Neovim state
cp -r "$BACKUP_DIR/state-nvim" ~/.local/state/nvim

# Restore Neovim cache
cp -r "$BACKUP_DIR/cache-nvim" ~/.cache/nvim

# Restore WezTerm config
cp "$BACKUP_DIR/wezterm.lua" ~/.wezterm.lua

echo "✓ Configuration restored from backup"
```

---

### Restore Previous Neovim Configuration (from installation backup)

If you had a previous Neovim configuration before installing NVChad:

```bash
# Find the most recent installation backup
ls -d ~/.config/nvim.backup.* | tail -1

# Restore it
BACKUP_DIR=$(ls -d ~/.config/nvim.backup.* | tail -1)
if [ -n "$BACKUP_DIR" ]; then
  rm -rf ~/.config/nvim
  mv "$BACKUP_DIR" ~/.config/nvim
  echo "✓ Previous configuration restored"
else
  echo "⚠ No installation backup found"
fi
```

---

## Post-Uninstallation

### What Was Removed

Depending on your choices, the following were removed:

**If you chose option (a) - Custom config only**:
- ✓ Custom key mappings (lua/mappings/)
- ✓ Custom plugin configurations
- ✓ Custom LSP configurations
- ✗ NVChad base (preserved)

**If you chose option (b) - Complete NVChad**:
- ✓ All Neovim configuration files
- ✓ All installed plugins
- ✓ All language servers (Mason)
- ✓ All Neovim data and cache
- ✗ Neovim application (preserved)

**If you chose option (c) - Include WezTerm**:
- ✓ All from option (b)
- ✓ WezTerm Neovim mappings (or entire config)

**If you chose option (d) - Full removal**:
- ✓ All from option (c)
- ✓ Neovim application itself

---

### Remaining System Components

These components are NOT removed and must be uninstalled separately if desired:

- **Git**: Required by many tools, left installed
- **Node.js**: Used by some language servers, left installed
- **Python**: Used by some language servers, left installed
- **Homebrew/apt/pacman**: Package managers left installed
- **WezTerm/iTerm2/Terminal.app**: Terminal applications left installed

---

## Troubleshooting

### Issue: "Neovim still shows NVChad after uninstall"

**Solution**:
```bash
# Ensure all directories are removed
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart your terminal
```

---

### Issue: "WezTerm keys not working after uninstall"

**Cause**: WezTerm is still using the modified config.

**Solution**:
```bash
# Restore from backup or remove config
rm ~/.wezterm.lua

# Restart WezTerm
```

---

### Issue: "Want to reinstall but getting errors"

**Solution**:
```bash
# Clean install - remove ALL Neovim traces
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Now follow the installation guide again
```

---

## Uninstallation Complete! ✅

The cross-platform NVChad configuration has been successfully removed.

**Next Steps**:

1. **If you want to reinstall**: Follow the installation guide again
2. **If you want vanilla Neovim**: Just use `nvim` - it will start with default settings
3. **If you want a different config**: You can now install any other Neovim configuration

**Questions?**

- Check the troubleshooting section above
- Open an issue on GitHub
- Refer to the installation guide if reinstalling

Thank you for trying the cross-platform NVChad configuration! 👋
