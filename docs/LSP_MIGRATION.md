# LSP Configuration Migration Guide

## Migration Date: Feb 2026
**Reason**: Neovim 0.11+ deprecated `require('lspconfig')` API in favor of `vim.lsp.config()`

---

## What Changed

### Old Structure (Deprecated)
```
lua/configs/
├── lspconfig.lua          # Used require('lspconfig')[name].setup {}
└── lsp/
    ├── init.lua           # Returned server modules
    ├── python.lua         # Server-specific setup with lspconfig param
    ├── go.lua
    └── bash.lua
```

### New Structure (Neovim 0.11+)
```
lua/configs/
├── lspconfig.lua          # Uses vim.lsp.config(name, config)
└── lsp/
    ├── init.lua           # Loads and registers servers
    ├── defaults.lua       # Shared NvChad defaults
    ├── util.lua           # Centralized utilities (root_pattern, path helpers)
    └── servers/           # Individual server configs
        ├── basedpyright.lua
        ├── gopls.lua
        └── bashls.lua
```

---

## Key API Changes

### 1. Server Registration

**Old API (nvim-lspconfig)**
```lua
local lspconfig = require("lspconfig")

lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  settings = { ... }
}
```

**New API (vim.lsp.config)**
```lua
vim.lsp.config("gopls", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
  settings = { ... }
})
```

### 2. Root Directory Patterns

**Old API**
```lua
local util = require('lspconfig.util')
root_dir = util.root_pattern("go.mod", ".git")
```

**New API**
```lua
local util = require("configs.lsp.util")
root_dir = util.root_pattern("go.mod", ".git")
```

Our `util.root_pattern` uses `vim.fs.find()` under the hood (native Neovim 0.11+ function).

### 3. Path Utilities

**Old API**
```lua
local util = require('lspconfig.util')
local path = util.path.join(workspace, '.venv', 'bin', 'python')
```

**New API**
```lua
local util = require("configs.lsp.util")
local path = util.path_join(workspace, '.venv', 'bin', 'python')
```

---

## New Features

### 1. Centralized Defaults (`defaults.lua`)
- Exports NvChad's `on_attach`, `on_init`, `capabilities`
- Provides `make_config(overrides)` helper to merge custom config with defaults

**Usage:**
```lua
local defaults = require("configs.lsp.defaults")

return defaults.make_config {
  settings = {
    gopls = {
      analyses = { unusedparams = true }
    }
  }
}
```

### 2. Utility Functions (`util.lua`)
- `root_pattern(...)` - Find project root by markers
- `path_join(...)` - Join path components
- `file_readable(filepath)` - Check file existence
- `get_python_path(workspace)` - Smart Python interpreter detection (.venv → poetry → pyenv → system)

### 3. Modular Server Configs (`servers/`)
Each server config is a pure table (no `M.setup` wrapper):

```lua
local defaults = require("configs.lsp.defaults")
local util = require("configs.lsp.util")

return defaults.make_config {
  root_dir = util.root_pattern("go.mod", ".git"),
  settings = { ... }
}
```

---

## Migration Checklist

- [x] Create `lua/configs/lsp/util.lua` with native Neovim utilities
- [x] Create `lua/configs/lsp/defaults.lua` for shared config
- [x] Move server configs to `lua/configs/lsp/servers/`
- [x] Update `lua/configs/lsp/init.lua` to use `vim.lsp.config()`
- [x] Update `lua/configs/lspconfig.lua` to use new API
- [x] Remove old `bash.lua`, `go.lua`, `python.lua` from `lsp/`
- [x] Test LSP functionality (gopls, basedpyright, bashls)

---

## Adding New Servers

### 1. For servers with default config only:
Edit `lua/configs/lspconfig.lua`:
```lua
local basic_servers = { "html", "cssls", "your_new_server" }
```

### 2. For servers with custom config:
Create `lua/configs/lsp/servers/your_server.lua`:
```lua
local defaults = require("configs.lsp.defaults")
local util = require("configs.lsp.util")

return defaults.make_config {
  root_dir = util.root_pattern("your-marker", ".git"),
  settings = {
    your_server = {
      -- Custom settings
    }
  }
}
```

Then register in `lua/configs/lsp/init.lua`:
```lua
local servers = {
  basedpyright = require("configs.lsp.servers.basedpyright"),
  gopls = require("configs.lsp.servers.gopls"),
  bashls = require("configs.lsp.servers.bashls"),
  your_server = require("configs.lsp.servers.your_server"),
}
```

---

## Benefits

1. **No more deprecation warnings** - Uses official Neovim 0.11+ API
2. **No external util dependency** - All utilities are local and native
3. **Cleaner separation** - Shared defaults vs server-specific config
4. **Easier to maintain** - Pure config tables, no wrapper functions
5. **Type-safe** - LuaLS annotations for autocomplete and type checking

---

## Rollback Instructions

If something breaks, restore old structure:

```bash
git checkout HEAD~1 -- lua/configs/lsp/
git checkout HEAD~1 -- lua/configs/lspconfig.lua
```

Then restart Neovim.
