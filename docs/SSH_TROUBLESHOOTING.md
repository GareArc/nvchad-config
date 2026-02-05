# SSH Keymap Override - Troubleshooting Guide

## Quick Diagnosis

When you SSH to a Linux server and `Space+p` (or other macOS shortcuts) don't work:

### Step 1: Verify Local Alias

On your **Mac** (before SSH'ing):

```bash
# Check if alias exists
alias | grep ssh
```

**Expected output:**
```
ssh='NVIM_KEYMAP=mac ssh'
```

**If missing:**
```bash
# Reload your shell config
source ~/.zshrc

# Try again
alias | grep ssh
```

---

### Step 2: Check Environment Variable on Remote Server

**SSH to your Linux server**, then:

```bash
# Check if NVIM_KEYMAP is set
echo $NVIM_KEYMAP
```

**Expected output:** `mac`

**If empty:** The environment variable didn't transfer. See Fix #1 below.

---

### Step 3: Test Neovim Keymap Detection

On the **remote server**, run:

```bash
nvim --headless -c "lua print(vim.inspect(os.getenv('NVIM_KEYMAP')))" -c "quit" 2>&1 | grep -v SetUserVar
```

**Expected output:** `"mac"`

**If `nil`:** The variable isn't reaching Neovim. See Fix #1 below.

---

### Step 4: Test Which Mappings Are Loaded

On the **remote server**, in Neovim:

```vim
:lua print(vim.inspect(vim.api.nvim_get_keymap('n')))
```

Look for `<leader>p` or `<leader>e` mappings.

**Or simpler test:**
- Press `Space+e` → Should toggle NvimTree
- Press `Space+p` → Should open Telescope

**If it opens Telescope with `Ctrl+P` but not `Space+p`:** Wrong keymap loaded (windows.lua instead of mac.lua).

---

## Common Fixes

### Fix #1: SSH Server Doesn't Accept Custom Environment Variables

**Problem:** Most SSH servers don't accept custom environment variables by default.

**Solution A: Use SSH Config (Recommended)**

On your **Mac**, add to `~/.ssh/config`:

```
Host *
    SetEnv NVIM_KEYMAP=mac
```

**OR** for specific servers only:

```
Host myserver.com
    SetEnv NVIM_KEYMAP=mac
```

Then test:
```bash
ssh user@myserver.com
echo $NVIM_KEYMAP  # Should show "mac"
```

**Solution B: Use Remote Wrapper Script**

If SSH server blocks environment variables, create a wrapper on the **remote server**:

```bash
# On the remote server
mkdir -p ~/bin
cat > ~/bin/nvim-mac << 'EOF'
#!/bin/bash
NVIM_KEYMAP=mac nvim "$@"
EOF
chmod +x ~/bin/nvim-mac

# Add to PATH
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Then use `nvim-mac` instead of `nvim`:
```bash
nvim-mac myfile.lua
```

---

### Fix #2: Alias Not Working

**Problem:** The `ssh` alias isn't being applied.

**Check:**
```bash
# What does 'ssh' resolve to?
type ssh
```

**Expected:** `ssh is aliased to 'NVIM_KEYMAP=mac ssh'`

**If not aliased:**
```bash
# Reload shell config
source ~/.zshrc

# Or manually set for this session
alias ssh='NVIM_KEYMAP=mac ssh'
```

**Permanent fix:**

Make sure the alias is in `~/.zshrc` (not `~/.bashrc` if you use zsh):

```bash
# Check your default shell
echo $SHELL

# If /bin/zsh, use ~/.zshrc
# If /bin/bash, use ~/.bashrc
```

---

### Fix #3: Using SSH Key Agent or Special SSH Commands

**Problem:** You're using `ssh` through other tools (like VS Code Remote SSH, tmux, etc.)

**Solution:** Set the variable in your remote shell profile instead.

On the **remote Linux server**, add to `~/.bashrc`:

```bash
# Force macOS keybindings in Neovim (for when SSH'ing from Mac)
export NVIM_KEYMAP=mac
```

Then:
```bash
source ~/.bashrc
```

**Downside:** This forces Mac keybindings even when SSH'ing from other systems.

**Better approach:** Detect the client.

On the **remote server** in `~/.bashrc`:

```bash
# Detect if SSH'ing from macOS (checks SSH client's terminal)
if [[ "$SSH_CLIENT" != "" ]] && [[ "$TERM_PROGRAM" == "WezTerm" || "$LC_TERMINAL" == "iTerm2" ]]; then
    export NVIM_KEYMAP=mac
fi
```

---

### Fix #4: Remote Server Neovim Config Is Different

**Problem:** The remote server has a different Neovim config (not this repo).

**Check on remote server:**
```bash
ls -la ~/.config/nvim/lua/mappings/
```

**Expected:** Should show `init.lua`, `mac.lua`, `windows.lua`, etc.

**If missing:** The remote server doesn't have this NvChad config installed.

**Solution:** Install this config on the remote server:

```bash
# On remote Linux server
git clone https://github.com/GareArc/nvchad-config.git /tmp/nvchad-config
cp -r /tmp/nvchad-config/lua ~/.config/nvim/
cp /tmp/nvchad-config/init.lua ~/.config/nvim/
rm -rf /tmp/nvchad-config
```

---

## Verification Checklist

After applying fixes, verify:

- [ ] `echo $NVIM_KEYMAP` on remote server shows `mac`
- [ ] `Space+e` toggles NvimTree in remote Neovim
- [ ] `Space+p` opens Telescope in remote Neovim
- [ ] `Space+s` saves files in remote Neovim
- [ ] `F12` goes to definition (should work regardless)

---

## Still Not Working?

### Debug: Check Which Keymap Is Actually Loaded

On the **remote server**, create a test file:

```bash
nvim /tmp/test-keymap.lua
```

In Neovim, run:

```vim
:lua print(os.getenv("NVIM_KEYMAP"))
:lua print(vim.uv.os_uname().sysname)
```

**Debugging table:**

| NVIM_KEYMAP | OS Detected | Keymap Loaded | Expected? |
|-------------|-------------|---------------|-----------|
| `mac` | `Linux` | `mac.lua` | ✅ Correct |
| `nil` | `Linux` | `windows.lua` | ❌ Variable not set |
| `mac` | `Darwin` | `mac.lua` | ⚠️ On Mac locally? |

---

## Alternative: Use Same Keybindings Everywhere

If SSH environment variables are too troublesome, consider using **universal keybindings** that work everywhere:

**Option A:** Modify your Mac config to use Ctrl instead of Space leader (not recommended).

**Option B:** Use both Space leader AND Ctrl keybindings everywhere:

In `lua/mappings/mac.lua`, add duplicate Ctrl bindings:

```lua
-- Universal shortcuts that work over SSH
map("n", "<C-p>", ":Telescope git_files<CR>", { desc = "Quick open" })
map("n", "<C-e>", ":NvimTreeToggle<CR>", { desc = "Toggle sidebar" })
-- etc.
```

This way:
- `Space+p` works locally on Mac
- `Ctrl+P` works over SSH (and locally too)

**Downside:** More keybindings to remember.

---

## Summary of Best Practices

**For most users:**
1. Use `~/.ssh/config` with `SetEnv NVIM_KEYMAP=mac`
2. Install this NvChad config on remote servers
3. Test with `echo $NVIM_KEYMAP` after SSH'ing

**For maximum compatibility:**
1. Set `export NVIM_KEYMAP=mac` in remote `~/.bashrc`
2. Add client detection to avoid forcing Mac keys for all users

**For quick testing:**
```bash
NVIM_KEYMAP=mac ssh user@server.com
```
