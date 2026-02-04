# Update Guide - NVChad Custom Configuration

> **For LLM Agents**: This guide is for updating an existing NVChad installation with the latest custom configuration changes. For fresh installations, see [INSTALLATION.md](./INSTALLATION.md).

## Overview

This guide helps you update your existing NVChad configuration with the latest changes from the `nvchad-config` repository without reinstalling everything from scratch.

**Use this guide when**:
- You already have this configuration installed
- You want to pull the latest custom settings (keybindings, plugins, themes)
- You want to sync repository changes to your local Neovim setup

**Estimated Time**: 5-10 minutes

---

## Prerequisites

Before updating, ensure:

1. **You have an existing installation** of this NVChad configuration
2. **Neovim is working** and you can open it without errors
3. **Git is installed** and accessible from command line

---

## Update Methods

Choose the method that fits your needs:

### Method 1: Quick Update (Recommended)

Use this if you haven't made custom modifications to the config files.

### Method 2: Manual Merge Update

Use this if you've customized config files and want to preserve your changes.

---

## Method 1: Quick Update

This method pulls the latest changes and applies them directly to your Neovim configuration.

### Step 1: Backup Current Configuration

```bash
# Create timestamped backup
cp -r ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)

echo "Backup created at ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
```

**Verify backup**:
```bash
ls -la ~/.config/ | grep nvim.backup
```

---

### Step 2: Pull Latest Configuration

```bash
# Clone latest config to temp directory
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config-update

# Navigate to your Neovim config
cd ~/.config/nvim
```

**Verify clone**:
```bash
ls /tmp/nvchad-config-update
```

Expected: Should show `lua/`, `init.lua`, `README.md`, etc.

---

### Step 3: Apply Updates

```bash
# Copy updated files (overwrites existing)
cp -r /tmp/nvchad-config-update/lua ~/.config/nvim/
cp /tmp/nvchad-config-update/init.lua ~/.config/nvim/
cp /tmp/nvchad-config-update/.stylua.toml ~/.config/nvim/ 2>/dev/null || true

# Clean up temp directory
rm -rf /tmp/nvchad-config-update

echo "Configuration updated successfully"
```

---

### Step 4: Update Plugins

```bash
# Launch Neovim
nvim
```

Inside Neovim, run:

```vim
:Lazy sync
```

**What happens**:
- Updates NVChad core (v2.5 branch)
- Updates all plugins to latest versions
- Installs any newly added plugins
- Removes deprecated plugins

Wait for completion (green checkmarks), then quit: `:q`

---

### Step 5: Update Language Servers

```bash
nvim
```

Inside Neovim, run:

```vim
:MasonUpdate
```

Then install any new language servers:

```vim
:MasonInstallAll
```

**Wait for completion**, then quit: `:q`

---

### Step 6: Verify Update

```bash
# Test Neovim loads without errors
nvim --headless -c "quit" 2>&1
```

Expected: Should exit cleanly with no error messages.

```bash
# Launch Neovim
nvim
```

**Test these shortcuts** (based on your OS):

**macOS**:
- `Space+p` - Quick open
- `F12` - Go to definition (in code files)
- `Space+lr` - Find references

**Windows/Linux**:
- `Ctrl+P` - Quick open
- `F12` - Go to definition
- `Ctrl+Shift+F12` - Find references

**Ask yourself**: "Did the shortcuts work as expected?"

If **yes**: Update complete! ✅

If **no**: See troubleshooting section below.

---

## Method 2: Manual Merge Update

Use this method if you've made custom modifications and want to carefully merge updates.

### Step 1: Check Your Current Modifications

```bash
cd ~/.config/nvim

# Check if your config is a git repository
if [ -d .git ]; then
  echo "Config is tracked with git"
  git status
else
  echo "Config is not tracked with git"
fi
```

---

### Step 2: Backup Current Configuration

```bash
# Create timestamped backup
cp -r ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)

echo "Backup created"
```

---

### Step 3: Clone Latest Configuration

```bash
# Clone to temp directory for comparison
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config-update
```

---

### Step 4: Compare and Merge Changes

Use a diff tool to compare files:

```bash
# Compare init.lua
diff ~/.config/nvim/init.lua /tmp/nvchad-config-update/init.lua

# Compare mappings
diff -r ~/.config/nvim/lua/mappings/ /tmp/nvchad-config-update/lua/mappings/

# Compare plugins
diff -r ~/.config/nvim/lua/plugins/ /tmp/nvchad-config-update/lua/plugins/
```

**Ask user**: "Would you like to see the differences between your current config and the latest version? (yes/no)"

If **yes**, show diffs and ask which changes to apply.

---

### Step 5: Selectively Apply Updates

```bash
# Example: Update only keybindings for macOS
cp /tmp/nvchad-config-update/lua/mappings/mac.lua ~/.config/nvim/lua/mappings/mac.lua

# Example: Update only theme settings
cp /tmp/nvchad-config-update/lua/chadrc.lua ~/.config/nvim/lua/chadrc.lua

# Example: Update specific plugin config
cp /tmp/nvchad-config-update/lua/plugins/copilot.lua ~/.config/nvim/lua/plugins/copilot.lua
```

**Ask user**: "Which files would you like to update? Provide file paths or 'all' for everything."

---

### Step 6: Clean Up and Verify

```bash
# Remove temp directory
rm -rf /tmp/nvchad-config-update

# Test Neovim
nvim --headless -c "quit" 2>&1
```

Then follow Steps 4-6 from Method 1 to update plugins and verify.

---

## Updating Specific Components

### Update Only Keybindings

```bash
# Clone latest
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config-update

# Update mappings
cp -r /tmp/nvchad-config-update/lua/mappings/ ~/.config/nvim/lua/

# Clean up
rm -rf /tmp/nvchad-config-update

echo "Keybindings updated. Restart Neovim to apply."
```

---

### Update Only Plugins

```bash
# Clone latest
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config-update

# Update plugins
cp -r /tmp/nvchad-config-update/lua/plugins/ ~/.config/nvim/lua/

# Clean up
rm -rf /tmp/nvchad-config-update

echo "Plugins updated. Run :Lazy sync in Neovim."
```

---

### Update Only Theme

```bash
# Clone latest
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config-update

# Update theme config
cp /tmp/nvchad-config-update/lua/chadrc.lua ~/.config/nvim/lua/
cp /tmp/nvchad-config-update/init.lua ~/.config/nvim/

# Clean up
rm -rf /tmp/nvchad-config-update

echo "Theme updated. Restart Neovim to apply."
```

---

### Update Only LSP Configuration

```bash
# Clone latest
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config-update

# Update LSP configs
cp -r /tmp/nvchad-config-update/lua/configs/lsp/ ~/.config/nvim/lua/configs/
cp /tmp/nvchad-config-update/lua/configs/lspconfig.lua ~/.config/nvim/lua/configs/

# Clean up
rm -rf /tmp/nvchad-config-update

echo "LSP config updated. Run :MasonInstallAll in Neovim."
```

---

## Rolling Back Updates

If something breaks after updating:

### Restore from Backup

```bash
# List available backups
ls -la ~/.config/ | grep nvim.backup

# Restore from specific backup (replace timestamp)
rm -rf ~/.config/nvim
cp -r ~/.config/nvim.backup.20260204_153000 ~/.config/nvim

echo "Rolled back to backup"
```

---

### Verify Rollback

```bash
# Test Neovim
nvim --headless -c "quit" 2>&1

# If successful, launch
nvim
```

**Ask user**: "Did the rollback fix the issue? (yes/no)"

If **no**: Consider reinstalling from scratch using [INSTALLATION.md](./INSTALLATION.md).

---

## Troubleshooting

### Issue: "Config file conflicts after update"

**Symptoms**: Neovim shows errors about duplicate mappings or plugins.

**Solution**:

1. Check for duplicate files:
```bash
find ~/.config/nvim/lua/ -name "*.lua.bak" -o -name "*.lua~"
```

2. Remove backup files:
```bash
find ~/.config/nvim/lua/ -name "*.lua.bak" -delete
find ~/.config/nvim/lua/ -name "*.lua~" -delete
```

3. Restart Neovim.

---

### Issue: "Plugins not updating"

**Symptoms**: `:Lazy sync` completes but plugins seem outdated.

**Solution**:

1. Clear plugin cache:
```bash
rm -rf ~/.local/share/nvim/lazy
```

2. Restart Neovim (plugins will reinstall automatically).

3. Run `:Lazy sync` again.

---

### Issue: "LSP stopped working after update"

**Symptoms**: No code completion, go-to-definition not working.

**Solution**:

1. Check Mason status:
```vim
:Mason
```

2. Reinstall language servers:
```vim
:MasonUninstallAll
:MasonInstallAll
```

3. Restart Neovim.

4. Check LSP status in a file:
```vim
:LspInfo
```

---

### Issue: "Theme looks broken after update"

**Symptoms**: Colors are wrong, UI elements missing.

**Solution**:

1. Clear theme cache:
```bash
rm -rf ~/.local/share/nvim/base46
```

2. Restart Neovim (theme will regenerate).

3. If still broken, check theme setting:
```bash
grep "colorscheme" ~/.config/nvim/init.lua
```

Expected: `vim.cmd.colorscheme "catppuccin-frappe"`

---

### Issue: "Getting Lua errors after update"

**Symptoms**: Errors like `module 'xyz' not found` or `attempt to index nil value`.

**Solution**:

1. Check for syntax errors:
```bash
nvim --headless -c "lua vim.print(vim.inspect(require('mappings')))" -c "quit" 2>&1
```

2. If errors appear, restore from backup:
```bash
rm -rf ~/.config/nvim
cp -r ~/.config/nvim.backup.TIMESTAMP ~/.config/nvim
```

3. Try updating again with Method 2 (Manual Merge).

---

## Keeping Your Config in Sync

### Option 1: Manual Updates (Current Method)

Follow this guide whenever you want to pull latest changes.

### Option 2: Track Your Config with Git

Initialize your config as a git repository with this repo as remote:

```bash
cd ~/.config/nvim

# Initialize git
git init

# Add remote
git remote add upstream https://github.com/GareArc/nvchad-config.git

# Fetch latest
git fetch upstream

# Merge changes (may need conflict resolution)
git merge upstream/main
```

**Pros**: Easy to see changes, can revert easily
**Cons**: Requires git knowledge, may need to resolve conflicts

---

### Option 3: Fork and Customize

1. Fork the repository on GitHub
2. Clone your fork to `~/.config/nvim`
3. Make customizations
4. Pull updates from upstream when needed

**Pros**: Full control, can push your changes
**Cons**: Requires GitHub account and git expertise

---

## Update Checklist

After updating, verify:

- [ ] Neovim launches without errors
- [ ] Keybindings work (test 3-5 shortcuts)
- [ ] LSP works (open code file, test completion)
- [ ] Plugins loaded (run `:Lazy` - all green checkmarks)
- [ ] Theme looks correct
- [ ] File tree works (toggle with `Space+b` or `Ctrl+B`)
- [ ] Telescope works (search with `Space+p` or `Ctrl+P`)

---

## What Gets Updated

When you update using this guide:

| Component | Updated | Notes |
|-----------|---------|-------|
| Keybindings | ✅ Yes | Platform-specific mappings |
| Plugins | ✅ Yes | Plugin definitions in `lua/plugins/` |
| LSP Config | ✅ Yes | Language server settings |
| Theme | ✅ Yes | Colorscheme and UI settings |
| NVChad Core | ✅ Yes | Via `:Lazy sync` |
| Custom Files | ❌ No | Your personal customizations preserved |

---

## Update Complete!

Your NVChad configuration is now up to date with the latest changes.

**What's Next**:

1. **Review Changes**: Check the repository's commit history to see what's new
2. **Test Thoroughly**: Spend 10-15 minutes using Neovim to catch any issues
3. **Report Issues**: If you find bugs, open an issue on GitHub

**Need Help?**

- Check the troubleshooting section above
- Review [INSTALLATION.md](./INSTALLATION.md) for setup details
- Review [UNINSTALLATION.md](./UNINSTALLATION.md) if you need to start fresh
- Open an issue on GitHub
