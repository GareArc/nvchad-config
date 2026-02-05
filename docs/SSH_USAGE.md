# SSH Usage Guide - NvChad Keymap Override

## The Problem

When you SSH from macOS to a Linux server:
- The remote NvChad detects the **server's OS** (Linux)
- It loads `windows.lua` (Ctrl-based shortcuts)
- But you're typing on a **Mac keyboard** expecting Space leader shortcuts

## The Solution

Use the `NVIM_KEYMAP` environment variable to override OS detection.

---

## Setup (One-Time)

Add these aliases to your `~/.zshrc` (or `~/.bashrc` if using bash):

```bash
# NvChad keymap override for SSH
# Use 'ssh-mac' when SSH'ing from macOS to Linux servers
alias ssh-mac='NVIM_KEYMAP=mac ssh'

# Or use regular 'ssh' for default behavior (server OS detection)
```

### Apply Changes

```bash
source ~/.zshrc
```

---

## Usage

### Option 1: SSH with Mac Keybindings (Recommended)

Use `ssh-mac` instead of `ssh`:

```bash
ssh-mac user@your-server.com
```

Then in Neovim on the remote server:
- `Space+e` → Toggle sidebar
- `Space+p` → Quick open
- `F12` → Go to definition
- All Mac shortcuts work!

---

### Option 2: SSH with Default Behavior

Use regular `ssh`:

```bash
ssh user@your-server.com
```

Then in Neovim on the remote server:
- Uses server's OS detection (Linux)
- Loads `windows.lua` (Ctrl-based shortcuts)
- `Ctrl+B` for sidebar, `Ctrl+P` for quick open, etc.

---

## Manual Override (Alternative Method)

Set the variable manually before connecting:

```bash
export NVIM_KEYMAP=mac
ssh user@your-server.com
```

Or in one command:

```bash
NVIM_KEYMAP=mac ssh user@your-server.com
```

---

## Verification

After SSH'ing with `ssh-mac`, check which keymap loaded:

```bash
# In Neovim on remote server
:lua print(vim.inspect(require("mappings")))
```

Or test directly:
- Press `Space+e` → Should toggle NvimTree
- Press `Space+p` → Should open Telescope

---

## Troubleshooting

> **Detailed troubleshooting guide:** See [SSH_TROUBLESHOOTING.md](./SSH_TROUBLESHOOTING.md) for comprehensive diagnostics and fixes.

### Issue: "Space+e still doesn't work after ssh-mac"

**Check environment variable:**

```bash
# On remote server
echo $NVIM_KEYMAP
```

Expected: `mac`

If empty, the alias might not have passed the variable. Try:

```bash
NVIM_KEYMAP=mac ssh -o SendEnv=NVIM_KEYMAP user@server.com
```

And add to `~/.ssh/config`:

```
Host *
    SendEnv NVIM_KEYMAP
```

Then on the **remote server**, ensure `~/.ssh/sshd_config` (or `/etc/ssh/sshd_config`) has:

```
AcceptEnv NVIM_KEYMAP
```

---

### Issue: "Variable not persisting in SSH session"

Some SSH servers don't accept custom environment variables.

**Solution**: Use a wrapper script instead:

```bash
# Create ~/bin/nvim-mac (on remote server)
#!/bin/bash
NVIM_KEYMAP=mac nvim "$@"
```

```bash
chmod +x ~/bin/nvim-mac
```

Then use `nvim-mac` instead of `nvim` when SSH'd.

---

## Available Override Values

| Value | Effect |
|-------|--------|
| `mac` | Force macOS mappings (Space leader) |
| `windows` | Force Windows/Linux mappings (Ctrl-based) |
| (unset) | Auto-detect based on server OS |

---

## Key Differences

### Mac Mappings (Space Leader)

| Shortcut | Action |
|----------|--------|
| `Space+e` | Toggle sidebar |
| `Space+b` | Focus sidebar |
| `Space+p` | Quick open |
| `Space+s` | Save |
| `F12` | Go to definition |

### Windows/Linux Mappings (Ctrl)

| Shortcut | Action |
|----------|--------|
| `Ctrl+B` | Toggle sidebar |
| `Ctrl+E` | Focus sidebar |
| `Ctrl+P` | Quick open |
| `Ctrl+S` | Save |
| `F12` | Go to definition |

---

## Recommendation

**For daily use**: Add the `ssh-mac` alias and use it consistently when connecting to Linux servers from your Mac. This gives you muscle memory consistency across local and remote environments.
