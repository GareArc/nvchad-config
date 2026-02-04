# Overview

This is a custom cross-platform NvChad configuration with VSCode-compatible keybindings for both Windows and macOS.

## Features

- **Cross-Platform Support**: Automatic OS detection loads platform-specific keybindings
  - **macOS**: Cmd-based shortcuts (⌘+S, ⌘+P, etc.)
  - **Windows/Linux**: Ctrl-based shortcuts (Ctrl+S, Ctrl+P, etc.)
- **VSCode Parity**: 49 essential VSCode shortcuts implemented across 6 categories
- **WezTerm Integration**: Cmd key support on macOS via escape sequences
- **Preserved Functionality**: All existing custom mappings maintained

## Installation

### For Human Users

Follow the standard installation steps below, or see the [detailed installation guide](docs/INSTALLATION.md) for troubleshooting.

#### Quick Install

1. Install NvChad Configuration:
```shell
curl -sSL https://raw.githubusercontent.com/GareArc/nvchad-config/refs/heads/main/install.sh | bash
```

2. Install Language Servers:
```vim
:MasonInstallAll
```

3. Configure WezTerm (macOS only)

For Cmd key support on macOS, you need to configure WezTerm to send Cmd keys as escape sequences to Neovim. See [Step 4 in the installation guide](docs/INSTALLATION.md#step-4-configure-wezterm-macos-only) for detailed instructions.

### For LLM Agents

Fetch the installation guide and follow it step-by-step:

```bash
curl -s https://raw.githubusercontent.com/GareArc/nvchad-config/main/docs/INSTALLATION.md
```

The installation guide will:
- Check all prerequisites before proceeding
- Ask for user confirmation at each step
- Handle errors and provide troubleshooting
- Verify installation success

For uninstallation:

```bash
curl -s https://raw.githubusercontent.com/GareArc/nvchad-config/main/docs/UNINSTALLATION.md
```

## Keybinding Categories

### File Operations (9 shortcuts)
- Save, Save As, Close, New File, Open File, Quick Open, Command Palette

### Search & Replace (7 shortcuts)
- Find, Replace, Find in Files, Replace in Files, Go to Line

### Editing (11 shortcuts)
- Undo/Redo, Cut/Copy/Paste, Comment, Multi-cursor, Delete Line, Move Line, Insert Line, Indent

### Navigation (8 shortcuts)
- Go to Definition, Find References, Go to Symbol, Go Back/Forward, Scroll

### Window & View (9 shortcuts)
- Toggle Sidebar, Toggle Terminal, Split Editor, Focus Editor Groups

### Tab/Buffer Management (5 shortcuts)
- Next/Previous Tab, Close Tab, Reopen Closed Tab

## Platform-Specific Notes

### macOS
- Uses Cmd (⌘) key for all shortcuts
- Requires WezTerm configuration for Cmd key support
- Line movement: Cmd+Shift+Up/Down (not Alt+Up/Down)
- Clipboard: Both system clipboard (Cmd+C/V) and Neovim registers (y/p) available

### Windows/Linux
- Uses Ctrl key for all shortcuts
- Works out of the box with any terminal
- All 153 existing custom mappings preserved

## File Structure

```
lua/
├── mappings/
│   ├── init.lua       # OS detection and loader
│   ├── common.lua     # Shared mappings (platform-agnostic)
│   ├── windows.lua    # Windows/Linux mappings (Ctrl-based)
│   └── mac.lua        # macOS mappings (Cmd-based)
├── plugins/           # Plugin configurations
├── configs/           # LSP and tool configurations
└── options.lua        # Editor options
```

## Troubleshooting

### Cmd keys not working on macOS
1. Verify WezTerm is configured to send Cmd keys as escape sequences
2. Check that IS_NVIM user variable is set in WezTerm
3. Test with `:echo getchar()` in Neovim and press Cmd+S (should show escape sequence)

### Shortcuts conflicting with existing mappings
The configuration preserves all existing custom mappings. If conflicts occur, check `lua/mappings/windows.lua` or `lua/mappings/mac.lua` and adjust as needed.

### OS detection not working
The configuration uses `vim.uv.os_uname().sysname` to detect the OS:
- "Darwin" → macOS (loads mac.lua)
- "Windows_NT" → Windows (loads windows.lua)
- Other → Linux (loads windows.lua)

## Contributing

Feel free to submit issues or pull requests for improvements!
